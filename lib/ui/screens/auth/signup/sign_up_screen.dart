import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:acudia/core/providers/sign_up_provider.dart';
import 'package:acudia/ui/screens/auth/signup/sign_up_basic_info_screen.dart';
import 'package:acudia/ui/screens/auth/signup/sign_up_profile_screen.dart';
import 'package:acudia/ui/screens/auth/signup/sign_up_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<Step> buildSteps(selectedTab) {
      return [
        Step(
            title: Text(translate(context, 'auth_step1'),
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w500)),
            isActive: selectedTab >= 0,
            state: selectedTab == 2 ? StepState.complete : StepState.indexed,
            content: SignUpBasicInfo()),
        Step(
            title: Text(translate(context, 'auth_step2'),
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w500)),
            isActive: selectedTab >= 1,
            state: selectedTab == 2 ? StepState.complete : StepState.indexed,
            content: SignUpProfile()),
        Step(
            title: Text(translate(context, 'auth_step3'),
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w500)),
            isActive: selectedTab >= 2,
            state: StepState.indexed,
            content: SignUpVerification()),
      ];
    }

    return Consumer2<SignUpProvider, ErrorNotifierProvider>(
        builder: (context, signup, errorProvider, child) => Scaffold(
              resizeToAvoidBottomPadding: false,
              appBar: AppBar(
                title: Text(translate(context, 'auth_register_label'),
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Colors.white)),
              ),
              body: ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                child: new Stack(children: <Widget>[
                  new Form(
                      key: _formKey,
                      child: Theme(
                          data: Theme.of(context).copyWith(
                              primaryColor: Theme.of(context).primaryColor),
                          child: Stepper(
                            steps: buildSteps(signup.selectedTab),
                            type: StepperType.horizontal,
                            currentStep: signup.selectedTab,
                            controlsBuilder: (BuildContext context,
                                    {VoidCallback onStepContinue,
                                    VoidCallback onStepCancel}) =>
                                Container(),
                            onStepTapped: (index) {
                              if (signup.selectedTab != 2) {
                                if (_formKey.currentState.validate()) {
                                  Provider.of<SignUpProvider>(context,
                                          listen: false)
                                      .setSelectedTab(index);
                                }
                              }
                            },
                          ))),
                ]),
              ),
              floatingActionButton: Container(
                  constraints:
                      BoxConstraints(minWidth: double.infinity, minHeight: 70),
                  child: FloatingActionButton(
                      shape: ContinuousRectangleBorder(),
                      backgroundColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (signup.selectedTab == 0) {
                          if (_formKey.currentState.validate()) {
                            Provider.of<SignUpProvider>(context, listen: false)
                                .setSelectedTab(signup.selectedTab + 1);
                          }
                        } else if (signup.selectedTab == 1) {
                          if (!Provider.of<SignUpProvider>(context,
                                  listen: false)
                              .validate()) {
                            Provider.of<SignUpProvider>(context, listen: false)
                                .signUp(context);
                          }
                        } else if (signup.selectedTab == 2) {
                          Provider.of<SignUpProvider>(context, listen: false)
                              .verifyEmail(context, signup.values[FIELD_EMAIL],
                                  signup.verificationCode);
                        }
                      },
                      isExtended: true,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                translate(
                                    context,
                                    signup.selectedTab == 2
                                        ? 'verify'
                                        : 'next'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward_ios, color: Colors.white)
                          ]))),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ));
  }
}
