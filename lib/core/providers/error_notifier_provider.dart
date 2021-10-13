import 'package:acudia/app_localizations.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ERROR_VISUALIZATIONS_TYPE { snackbar, dialog }

void showUnexpectedError(context) {
  showError(context, translate(context, 'error_unexpected'), translate(context, 'error_try_again_later'),
      ERROR_VISUALIZATIONS_TYPE.dialog);
}

void showModal({context, errorTitle, error, vtype, type, onCancel, onAccept}) {
  Provider.of<ErrorNotifierProvider>(context, listen: false).notifyError(
      errorTitle: errorTitle, error: error, vtype: vtype, type: type, onCancel: onCancel, onAccept: onAccept);
}

void showError(context, errorTitle, error, vtype) {
  Provider.of<ErrorNotifierProvider>(context, listen: false)
      .notifyError(errorTitle: errorTitle, error: error, vtype: vtype);
}

class ErrorNotifierProvider with ChangeNotifier {
  String _error;
  String _errorTitle;
  DialogType _type;
  ERROR_VISUALIZATIONS_TYPE _vtype;
  Function _onAccept;
  Function _onCancel;

  String get error => _error;
  String get errorTitle => _errorTitle;
  ERROR_VISUALIZATIONS_TYPE get vtype => _vtype;
  DialogType get type => _type;
  Function get onAccept => _onAccept;
  Function get onCancel => _onCancel;

  void notifyError(
      {dynamic error,
      dynamic errorTitle,
      DialogType type,
      ERROR_VISUALIZATIONS_TYPE vtype,
      Function onCancel,
      Function onAccept}) {
    _error = error.toString();
    _errorTitle = errorTitle.toString();
    _type = type;
    _vtype = vtype;
    _onAccept = onAccept;
    _onCancel = onCancel;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    _errorTitle = null;
    _type = DialogType.ERROR;
    _vtype = null;
    _onAccept = null;
    _onCancel = null;
  }
}
