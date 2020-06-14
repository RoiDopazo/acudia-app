import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ERROR_VISUALIZATIONS_TYPE { snackbar, dialog }

void showError(context, errorTitle, error, type) {
  Provider.of<ErrorNotifierProvider>(context, listen: false).notifyError(
      errorTitle: errorTitle,
      error: error,
      type: ERROR_VISUALIZATIONS_TYPE.dialog);
}

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
