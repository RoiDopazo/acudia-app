import 'package:flutter/material.dart';

enum ERROR_VISUALIZATIONS_TYPE { snackbar, dialog }

class ErrorNotifierProvider with ChangeNotifier {
  String _error;
  String _errorTitle;
  ERROR_VISUALIZATIONS_TYPE _type;

  String get error => _error;
  String get errorTitle => _errorTitle;
  ERROR_VISUALIZATIONS_TYPE get type => _type;

  void notifyError(
      {dynamic error, dynamic errorTitle, ERROR_VISUALIZATIONS_TYPE type}) {
    _error = error.toString();
    _errorTitle = errorTitle.toString();
    _type = type;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    _errorTitle = null;
    _type = null;
  }
}
