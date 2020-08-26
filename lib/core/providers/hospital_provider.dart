import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/services/hospital_service.dart';
import 'package:flutter/material.dart';

class HospitalProvider with ChangeNotifier {
  List<Hospital> hospList = [];
  List<Hospital> paginatedList = [];
  int currentPage = 1;
  int offset = 20;
  bool isSearching = false;
  bool isLoading = true;

  fetchHospitals() async {
    if (hospList.length == 0) {
      currentPage = 1;
      hospList = await HospitalService.find();
      int maxValue = currentPage * offset < hospList.length
          ? currentPage * offset
          : hospList.length;
      paginatedList = hospList.sublist(0, maxValue);
      isLoading = false;
      notifyListeners();
    }
  }

  searchHospitals({String searchValue}) async {
    isLoading = true;
    notifyListeners();
    currentPage = 1;
    hospList = await HospitalService.find(search: searchValue);
    int maxValue = currentPage * offset < hospList.length
        ? currentPage * offset
        : hospList.length;
    paginatedList = hospList.sublist(0, maxValue);
    isLoading = false;
    notifyListeners();
  }

  getMoreItems() {
    if ((currentPage + 1) * offset < hospList.length) {
      currentPage++;
      int maxValue = currentPage * offset < hospList.length
          ? currentPage * offset
          : hospList.length;
      paginatedList = hospList.sublist(0, maxValue);
      notifyListeners();
    }
  }

  toggleIsSearching({String searchValue}) async {
    isSearching = !isSearching;
    if (!isSearching && searchValue != '') {
      await searchHospitals();
    } else {
      notifyListeners();
    }
  }

  cleanup() {
    currentPage = 1;
  }
}
