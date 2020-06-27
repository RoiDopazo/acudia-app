import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class GenericError extends StatelessWidget {
  final dynamic errorProvider;

  const GenericError({Key key, @required this.errorProvider}) : super(key: key);

  void _showAlert(BuildContext context,
      {@required String errorTitle, @required String error}) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.SCALE,
      title: errorTitle,
      desc: error,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    if (errorProvider.vtype != null) {
      switch (errorProvider.vtype) {
        case ERROR_VISUALIZATIONS_TYPE.dialog:
          WidgetsBinding.instance.addPostFrameCallback((_) => _displayDialog(
              context,
              errorTitle: errorProvider.errorTitle,
              error: errorProvider.error,
              clearError: errorProvider.clearError));
          break;
        case ERROR_VISUALIZATIONS_TYPE.snackbar:
        default:
          WidgetsBinding.instance.addPostFrameCallback((_) => _displaySnackBar(
              context,
              error: errorProvider.error,
              clearError: errorProvider.clearError));
          break;
      }
    }
    return Container();
  }

  void _displaySnackBar(BuildContext context,
      {@required String error, clearError}) {
    final snackBar = SnackBar(content: Text(error));
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
    clearError();
  }

  void _displayDialog(BuildContext context,
      {@required String errorTitle, @required String error, clearError}) {
    _showAlert(context, errorTitle: errorTitle, error: error);
    clearError();
  }
}
