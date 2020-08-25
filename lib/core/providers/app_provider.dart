import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProvider with ChangeNotifier {
  int selectedTab = 1;

  setSelectedTab(context, tab) {
    if (tab >= 0 && tab <= 2) {
      selectedTab = tab;
      Provider.of<HospitalProvider>(context).cleanup();
      notifyListeners();
    }
  }
}
