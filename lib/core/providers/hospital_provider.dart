import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/services/hospital_service.dart';
import 'package:flutter/material.dart';

class HospitalProvider with ChangeNotifier {
  List<Hospital> hospList = [];
  List<Hospital> paginatedList = [];
  int currentPage = 1;
  int offset = 10;
  bool loading;

  fetchHospitals() async {
    if (hospList.length == 0) {
      hospList = await HospitalService.getAll();
      paginatedList = hospList.sublist(0, 1 * offset);
      notifyListeners();
    }
  }

  getMoreItems() {
    currentPage++;
    if (currentPage * offset < hospList.length) {
      paginatedList = hospList.sublist(0, currentPage * offset);
      notifyListeners();
    }
  }

  cleanup() {
    currentPage = 1;
  }
}
