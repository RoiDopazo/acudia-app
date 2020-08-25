import 'dart:convert';
import 'package:acudia/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:query_params/query_params.dart';

class HospitalService {
  static Future<List<Hospital>> getAll() async {
    URLQueryParams queryParams = new URLQueryParams();

    queryParams.append('where', "1=1");
    queryParams.append('outFields', '*');
    queryParams.append('returnGeometry', 'false');
    queryParams.append('f', 'json');

    final response =
        await http.get("$OPENDATA_HOSPITAL_API?${queryParams.toString()}");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> items = data["features"];
      List<Hospital> hospList = [];

      for (Map<String, dynamic> item in items.sublist(0, 70)) {
        hospList.add(Hospital.fromJson(item["attributes"]));
      }

      return hospList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
