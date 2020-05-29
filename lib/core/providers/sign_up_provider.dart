import 'package:flutter/material.dart';

const FIELD_NAME = 'name';
const FIELD_EMAIL = 'email';
const FIELD_PASSWORD = 'password';
const FIELD_GENDER = 'gender';

class SignUpProvider with ChangeNotifier {
  int selectedTab = 0;
  bool isRegistered = false;
  final values = {
    FIELD_NAME: '',
    FIELD_EMAIL: '',
    FIELD_PASSWORD: "",
    FIELD_GENDER: [false, false, false]
  };

  setSelectedTab(tab) {
    if (tab >= 0 && tab <= 2) {
      if (tab == 2 && !isRegistered) {
        return;
      }
      selectedTab = tab;
      notifyListeners();
    }
  }

  updateValue(key, value) {
    values[key] = value;
    notifyListeners();
  }
}
