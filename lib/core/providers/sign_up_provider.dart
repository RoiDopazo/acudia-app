import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  int selectedTab = 0;
  bool isRegistered = false;

  setSelectedTab(tab) {
    if (tab >= 0 && tab <= 2) {
      if (tab == 2 && !isRegistered) {
        return;
      }
      selectedTab = tab;
      notifyListeners();
    }
  }
}
