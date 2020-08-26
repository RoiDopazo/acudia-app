import 'dart:convert';
import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:query_params/query_params.dart';

const MAX_HOSP_VALUES = 200;

parseResponse(response) {
  var data = json.decode(response.body);
  List<dynamic> items = data["features"];
  List<dynamic> limitedItems = items.length > MAX_HOSP_VALUES
      ? items.sublist(0, MAX_HOSP_VALUES)
      : items;
  List<Hospital> hospList = [];

  for (Map<String, dynamic> item in limitedItems) {
    hospList.add(Hospital.fromJson(item["attributes"]));
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
        case FILTER_IS_NEAR:
          break;
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
            value =
                "$value AND (DEPENDENCIA_PATRIMONIAL LIKE '%PRIVADO%' OR DEPENDENCIA_FUNCIONAL LIKE '%PRIVADO%')";
            break;
          }
      }
    });
  }
  print(value);
  return value;
}

class HospitalService {
  static Future<List<Hospital>> find(
      {String search, List<String> filters}) async {
    print(filters);
    URLQueryParams queryParams = new URLQueryParams();

    queryParams.append(
        'where',
        buildWhereStatement(
            search: search, hideComplex: true, filters: filters));
    queryParams.append('outFields', '*');
    queryParams.append('returnGeometry', 'false');
    queryParams.append('f', 'json');

    final response =
        await http.get("$OPENDATA_HOSPITAL_API?${queryParams.toString()}");

    if (response.statusCode == 200) {
      return parseResponse(response);
    } else {
      throw Exception('Failed to get hospitals');
    }
  }
}
