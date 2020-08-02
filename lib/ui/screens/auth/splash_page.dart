import 'package:acudia/app_localizations.dart';
import 'package:acudia/colors.dart';
import 'package:acudia/core/providers/sign_up_provider.dart';
import 'package:acudia/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget svgIcon = SvgPicture.asset('assets/media/logo.svg',
        height: 200,
        color: Theme.of(context).accentColor,
        semanticsLabel: 'Acudia Logo');

    final logo = ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height / 2 + 50,
            maxHeight: MediaQuery.of(context).size.height / 2 + 50),
        child: Column(children: <Widget>[
          SizedBox(height: 32),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 0.0, 36.0, 8.0),
              child: svgIcon,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text("ACUDIA",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 44,
                    color: Theme.of(context).accentColor,
                    decoration: TextDecoration.none)),
          )
        ]));

    final loginButton = new ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 50.0,
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        padding: const EdgeInsets.all(16.0),
        textColor: Theme.of(context).backgroundColor,
        color: Theme.of(context).primaryColor,
        onPressed: () {
          showLoadingDialog();
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

    final loginForm = Column(children: <Widget>[
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        maxLines: 1,
        onChanged: (text) {
          Provider.of<SignUpProvider>(context, listen: false)
              .updateValue(FIELD_EMAIL, text);
        },
        decoration: new InputDecoration(
            labelText: translate(context, 'field_email_label'),
            hintText: translate(context, 'field_email_hint'),
            icon: const Icon(Icons.mail),
            labelStyle:
                new TextStyle(decorationStyle: TextDecorationStyle.solid)),
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        autocorrect: false,
        maxLines: 1,
        obscureText: true,
        onChanged: (text) {
          Provider.of<SignUpProvider>(context, listen: false)
              .updateValue(FIELD_PASSWORD, text);
        },
        decoration: new InputDecoration(
            labelText: translate(context, 'field_password_label'),
            hintText: translate(context, 'field_password_hint'),
            icon: const Icon(Icons.lock),
            labelStyle:
                new TextStyle(decorationStyle: TextDecorationStyle.solid)),
      ),
    ]);

    return Material(
        child: Container(
      color: Colors.white,
      child: CustomPaint(
        painter: CurvePainter(),
        child: Column(
          children: <Widget>[
            logo,
            ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height / 2 - 50,
                  maxHeight: MediaQuery.of(context).size.height / 2 - 50,
                ),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: loginForm,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: loginButton,
                        ),
                        SizedBox(height: 16),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: translate(
                                  context, 'auth_dont_have_acc_question'),
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15),
                              children: [
                                TextSpan(
                                    text: translate(context, 'auth_register'),
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ]),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    ));
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = aCPalette;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(
        size.width / 2, size.height / 1.5, size.width, size.height * 0.4);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
