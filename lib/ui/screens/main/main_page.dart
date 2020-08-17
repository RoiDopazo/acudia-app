import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/aws/cognito_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logoutButton = new ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 50.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side:
                BorderSide(color: Theme.of(context).textTheme.bodyText1.color)),
        padding: const EdgeInsets.all(16.0),
        textColor: Theme.of(context).textTheme.bodyText1.color,
        color: Theme.of(context).backgroundColor,
        onPressed: () {
          CognitoService.getUserData();
        },
        child: new Text('logout'),
      ),
    );

    return Scaffold(body: Center(child: logoutButton));
  }
}
