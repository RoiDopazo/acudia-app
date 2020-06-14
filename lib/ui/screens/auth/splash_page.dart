import 'package:acudia/app_localizations.dart';
import 'package:acudia/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget svgIcon = SvgPicture.asset('assets/media/logo.svg',
        color: Theme.of(context).primaryColor, semanticsLabel: 'Acudia Logo');

    final loginButton = new ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 50.0,
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        padding: const EdgeInsets.all(16.0),
        textColor: Theme.of(context).backgroundColor,
        color: Theme.of(context).primaryColor,
        onPressed: () {},
        child: new Text(translate(context, 'auth_login')),
      ),
    );

    final signUpButton = new ButtonTheme(
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
          Navigator.pushNamed(context, Routes.SignUp);
        },
        child: new Text(translate(context, 'auth_signUp')),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(36.0, 0.0, 36.0, 8.0),
                child: svgIcon,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child:
                  Text("ACUDIA", style: Theme.of(context).textTheme.headline1),
            ),
            SizedBox(height: 16),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: loginButton,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: signUpButton,
            ),
          ],
        ),
      ),
    );
  }
}
