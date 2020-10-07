import 'package:acudia/app_localizations.dart';
import 'package:acudia/colors.dart';
import 'package:acudia/core/providers/sign_up_provider.dart';
import 'package:acudia/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool showLogin = Provider.of<SignUpProvider>(context).showLogin;

    final Widget svgIcon = SvgPicture.asset('assets/media/logo.svg',
        height: 200, color: Theme.of(context).scaffoldBackgroundColor, semanticsLabel: 'Acudia Logo');

    final logo = ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height / 2 + 50,
            maxHeight: MediaQuery.of(context).size.height / 2 + 50),
        child: Column(children: <Widget>[
          SizedBox(height: 48),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 0.0, 36.0, 8.0),
              child: svgIcon,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text("ACUDIA",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 44,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    decoration: TextDecoration.none)),
          )
        ]));

    final loginButton = new ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 50.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        padding: const EdgeInsets.all(16.0),
        textColor: Theme.of(context).backgroundColor,
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Provider.of<SignUpProvider>(context).showLogin
              ? Provider.of<SignUpProvider>(context, listen: false).login(context)
              : Provider.of<SignUpProvider>(context, listen: false).setToggleLogin();
        },
        child: new Text(translate(context, 'auth_login')),
      ),
    );

    final signUpButton = new ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 50.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Theme.of(context).textTheme.bodyText1.color)),
        padding: const EdgeInsets.all(16.0),
        textColor: Theme.of(context).textTheme.bodyText1.color,
        color: Theme.of(context).backgroundColor,
        onPressed: () {
          Provider.of<SignUpProvider>(context, listen: false).resetValues();
          Navigator.pushNamed(context, Routes.SIGNUP);
        },
        child: new Text(translate(context, 'auth_signUp')),
      ),
    );

    final loginForm = Column(children: <Widget>[
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        maxLines: 1,
        onChanged: (text) {
          Provider.of<SignUpProvider>(context, listen: false).updateValue(FIELD_EMAIL, text);
        },
        decoration: new InputDecoration(
            labelText: translate(context, 'field_email_label'),
            hintText: translate(context, 'field_email_hint'),
            icon: const Icon(Icons.mail),
            labelStyle: new TextStyle(decorationStyle: TextDecorationStyle.solid)),
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        autocorrect: false,
        maxLines: 1,
        obscureText: true,
        onChanged: (text) {
          Provider.of<SignUpProvider>(context, listen: false).updateValue(FIELD_PASSWORD, text);
        },
        decoration: new InputDecoration(
            labelText: translate(context, 'field_password_label'),
            hintText: translate(context, 'field_password_hint'),
            icon: const Icon(Icons.lock),
            labelStyle: new TextStyle(decorationStyle: TextDecorationStyle.solid)),
      ),
    ]);

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(width: MediaQuery.of(context).size.width, child: CustomPaint(child: logo, painter: CurvePainter())),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Container(
              child: Column(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: showLogin ? loginForm : signUpButton,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: loginButton,
            ),
            SizedBox(height: 16),
            Container(
                child: showLogin
                    ? RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: translate(context, 'auth_dont_have_acc_question'),
                            style: TextStyle(color: Colors.black54, fontSize: 15),
                            children: [
                              TextSpan(
                                  text: translate(context, 'auth_register'),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      Provider.of<SignUpProvider>(context, listen: false).resetValues();
                                      Navigator.pushNamed(context, Routes.SIGNUP);
                                    },
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 16))
                            ]),
                      )
                    : null),
          ]))
        ])));
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = aCPalette;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width / 2, size.height / 1, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
