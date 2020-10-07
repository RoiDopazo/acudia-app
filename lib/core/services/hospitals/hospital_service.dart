import 'dart:convert';
import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/utils/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:query_params/query_params.dart';

const MAX_HOSP_VALUES = 200;

parseResponse(response, currentLocation) async {
  var data = json.decode(response.body);
  List<dynamic> items = data["features"];
  List<dynamic> limitedItems = items.length > MAX_HOSP_VALUES ? items.sublist(0, MAX_HOSP_VALUES) : items;
  List<Hospital> hospList = [];

  for (Map<String, dynamic> item in limitedItems) {
    Hospital hosp = Hospital.fromJson(item["attributes"]);
    if (currentLocation != null) {
      hosp.setDistance(await Geolocator()
          .distanceBetween(currentLocation["lat"], currentLocation["lng"], hosp.coords["lat"], hosp.coords["lng"]));
    }
    hospList.add(hosp);
  }

  if (currentLocation != null) {
    hospList.sort((a, b) => a.distance.compareTo(b.distance));
  }
  return hospList;
}

buildWhereStatement({String search, bool hideComplex, List<String> filters}) {
  String value = "1=1";
  if (search != null) {
    value = "NOMBRE LIKE '%$search%'";
  }
  if (hideComplex) {
    value = "$value AND ESCOMPLE='N'";
  }
  if (filters != null) {
    filters.forEach((element) {
      switch (element) {
        case FILTER_HOSP_GEN:
          {
            value = "$value AND CODFI=1";
            break;
          }
        case FILTER_HOSP_SPE:
          {
            value = "$value AND CODFI<>1";
            break;
          }
        case FILTER_PRIVATE:
          {
            value = "$value AND (DEPENDENCIA_PATRIMONIAL LIKE '%PRIVADO%' OR DEPENDENCIA_FUNCIONAL LIKE '%PRIVADO%')";
            break;
          }
      }
    });
  }

  return value;
}

buildGeometryStatement({double lat, double lng}) {
  String value = "${lng - 1},${lat - 1},${lng + 1},${lat + 1}";
  return value;
}

class HospitalService {
  static Future<List<Hospital>> find({String search, List<String> filters, Map<String, double> currentLocation}) async {
    final bool useCurrentLocation = (filters != null && filters.indexOf(FILTER_IS_NEAR) != -1);
    URLQueryParams queryParams = new URLQueryParams();

    queryParams.append('where', buildWhereStatement(search: search, hideComplex: true, filters: filters));
    queryParams.append('outFields', '*');
    if (filters != null && useCurrentLocation) {
      queryParams.append('geometry', buildGeometryStatement(lat: currentLocation["lat"], lng: currentLocation["lng"]));
      queryParams.append('geometryType', 'esriGeometryEnvelope');
      queryParams.append('inSR', '4326');
      queryParams.append('spatialRel', 'esriSpatialRelIntersects');
      queryParams.append('outSR', '4326');
    } else {
      queryParams.append('returnGeometry', 'false');
    }
    queryParams.append('f', 'json');

    final response = await http.get("$OPENDATA_HOSPITAL_API?${queryParams.toString()}");

    if (response.statusCode == 200) {
      return await parseResponse(response, currentLocation);
    } else {
      throw Exception('Failed to get hospitals');
    }
  }
}
