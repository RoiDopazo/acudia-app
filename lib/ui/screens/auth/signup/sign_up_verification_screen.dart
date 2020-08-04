import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/providers/sign_up_provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignUpVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
        builder: (context, signup, child) => Column(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: FlareActor(
                  "assets/media/otp.flr",
                  animation: "otp",
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: translate(context, 'email_verification_sub'),
                      children: [
                        TextSpan(
                            text: signup.values[FIELD_EMAIL],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 8),
              PinCodeTextField(
                length: 6,
                obsecureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Theme.of(context).scaffoldBackgroundColor,
                  inactiveFillColor: Theme.of(context).scaffoldBackgroundColor,
                  selectedFillColor: Theme.of(context).scaffoldBackgroundColor,
                  inactiveColor: Theme.of(context).accentColor,
                  activeColor: Theme.of(context).primaryColor,
                  selectedColor: Theme.of(context).primaryColor,
                ),
                onChanged: (value) {
                  Provider.of<SignUpProvider>(context, listen: false)
                      .setVerificationCode(value);
                },
                textStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                beforeTextPaste: (text) {
                  return true;
                },
              ),
              SizedBox(
                height: 16,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: translate(context, 'email_verification_not_received'),
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    children: [
                      TextSpan(
                          text: translate(context, 'resend'),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => Provider.of<SignUpProvider>(context,
                                    listen: false)
                                .resendVerificationCode(
                                    context, signup.values[FIELD_EMAIL]),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ]),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  padding: const EdgeInsets.all(16.0),
                  textColor: Theme.of(context).backgroundColor,
                  color: Theme.of(context).primaryColor,
                  onPressed: signup.verificationCode.length == 6
                      ? () =>
                          Provider.of<SignUpProvider>(context, listen: false)
                              .verifyEmail(context, signup.values[FIELD_EMAIL],
                                  signup.verificationCode)
                      : null,
                  child: new Text(translate(context, 'verificar')),
                ),
              ),
            ]));
  }
}
