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
              Container(
                height: MediaQuery.of(context).size.height / 3,
                // child: FlareActor(
                //   "assets/media/otp.flr",
                //   animation: "otp",
                //   fit: BoxFit.fitHeight,
                //   // color: Theme.of(context).secondaryHeaderColor,
                //   alignment: Alignment.center,
                // ),
              ),
              PinCodeTextField(
                length: 6,
                obsecureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Theme.of(context).backgroundColor,
                  inactiveFillColor: Theme.of(context).backgroundColor,
                  selectedFillColor: Theme.of(context).backgroundColor,
                  inactiveColor: Theme.of(context).accentColor,
                  activeColor: Theme.of(context).secondaryHeaderColor,
                  selectedColor: Theme.of(context).primaryColor,
                ),
                textStyle: TextStyle(
                    color: Theme.of(context).accentColor,
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
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              )
            ]));
  }
}
