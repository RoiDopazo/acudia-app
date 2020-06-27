import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ERROR_VISUALIZATIONS_TYPE { snackbar, dialog }

void showError(context, errorTitle, error, vtype) {
  Provider.of<ErrorNotifierProvider>(context, listen: false)
      .notifyError(errorTitle: errorTitle, error: error, vtype: vtype);
}

class ErrorNotifierProvider with ChangeNotifier {
  String _error;
  String _errorTitle;
  ERROR_VISUALIZATIONS_TYPE _vtype;

  String get error => _error;
  String get errorTitle => _errorTitle;
  ERROR_VISUALIZATIONS_TYPE get vtype => _vtype;

  void notifyError(
      {dynamic error, dynamic errorTitle, ERROR_VISUALIZATIONS_TYPE vtype}) {
    _error = error.toString();
    _errorTitle = errorTitle.toString();
    _vtype = vtype;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    _errorTitle = null;
    _vtype = null;
  }
}
