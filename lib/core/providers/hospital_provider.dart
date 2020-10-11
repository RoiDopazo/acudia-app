import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/services/hospitals/hospital_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

const FILTER_IS_NEAR = 'NEAR';
const FILTER_HOSP_GEN = 'HOSP_GEN';
const FILTER_HOSP_SPE = 'HOSP_SPE';
const FILTER_PRIVATE = 'IS_PRIVATE';

class HospitalProvider with ChangeNotifier {
  List<Hospital> hospList = [];
  List<Hospital> paginatedList = [];
  int currentPage = 1;
  int offset = 20;
  bool isSearching = false;
  bool useCurrentLocation = false;
  String searchQuery = '';
  bool isLoading = true;
  List<String> filters = [];
  Hospital selected;

  fetchHospitals() async {
    if (hospList.length == 0) {
      currentPage = 1;
      hospList = await HospitalService.find();
      int maxValue = currentPage * offset < hospList.length ? currentPage * offset : hospList.length;
      paginatedList = hospList.sublist(0, maxValue);
      isLoading = false;
      notifyListeners();
    }
  }

  searchHospitals({String searchValue}) async {
    isLoading = true;
    searchQuery = searchValue;
    notifyListeners();
    try {
      currentPage = 1;
      Position position;
      if (useCurrentLocation) {
        position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      }
      hospList = await HospitalService.find(
          search: searchValue,
          filters: filters,
          currentLocation: useCurrentLocation ? {"lat": position.latitude, "lng": position.longitude} : null);
      int maxValue = currentPage * offset < hospList.length ? currentPage * offset : hospList.length;
      paginatedList = hospList.sublist(0, maxValue);
      isLoading = false;
    } catch (error) {
      isLoading = false;
    }
    notifyListeners();
  }

  getMoreItems() {
    if ((currentPage + 1) * offset < hospList.length) {
      currentPage++;
      int maxValue = currentPage * offset < hospList.length ? currentPage * offset : hospList.length;
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

  toggleFilter(String filter) async {
    if (filters.indexOf(filter) == -1) {
      if ([FILTER_HOSP_GEN, FILTER_HOSP_SPE].indexOf(filter) != -1) {
        filters.remove(FILTER_HOSP_GEN);
        filters.remove(FILTER_HOSP_SPE);
      }
      filters.add(filter);
    } else {
      filters.remove(filter);
    }
    useCurrentLocation = filters.indexOf(FILTER_IS_NEAR) != -1;
    await searchHospitals(searchValue: searchQuery);
  }

  setSelectedHospital(Hospital hospital) {
    if (selected != null && selected.codCNH == hospital.codCNH) {
      selected = null;
    } else {
      selected = hospital;
    }
    notifyListeners();
  }

  cleanup() {
    currentPage = 1;
    useCurrentLocation = false;
    filters = [];
    searchQuery = '';
    isLoading = true;
    isSearching = false;
    hospList = [];
    selected = null;
  }
}
