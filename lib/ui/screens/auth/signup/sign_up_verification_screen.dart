import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/providers/sign_up_provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignUpVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
        builder: (context, signup, child) => Column(children: <Widget>[
              // Container(
              //   height: MediaQuery.of(context).size.height / 3,
              //   child: FlareActor(
              //     "assets/media/otp.flr",
              //     animation: "otp",
              //     fit: BoxFit.fitHeight,
              //     alignment: Alignment.center,
              //   ),
              // ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  translate(context, 'email_verification_label'),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
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
              SizedBox(height: 16),
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
                textStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
              SizedBox(
                height: 24,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: translate(context, 'email_verification_not_received'),
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    children: [
                      TextSpan(
                          text: translate(context, 'resend'),
                          // recognizer: () {},
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ]),
              ),
              SizedBox(
                height: 14,
              ),
            ]));
  }
}
