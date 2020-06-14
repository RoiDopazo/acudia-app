import 'package:acudia/app_localizations.dart';
import 'package:acudia/components/generic_error.dart';
import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:acudia/core/providers/sign_up_provider.dart';
import 'package:acudia/ui/screens/auth/signup/sign_up_basic_info_screen.dart';
import 'package:acudia/ui/screens/auth/signup/sign_up_profile_screen.dart';
import 'package:acudia/ui/screens/auth/signup/sign_up_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Step> buildSteps(selectedTab) {
      print(selectedTab == 2);
      return [
        Step(
            title: Text(translate(context, 'auth_step1'),
                style: Theme.of(context).textTheme.headline3),
            isActive: selectedTab >= 0,
            state: selectedTab == 2 ? StepState.complete : StepState.indexed,
            content: Theme(
                data: Theme.of(context)
                    .copyWith(primaryColor: Theme.of(context).accentColor),
                child: SignUpBasicInfo())),
        Step(
            title: Text(translate(context, 'auth_step2'),
                style: Theme.of(context).textTheme.headline3),
            isActive: selectedTab >= 1,
            state: selectedTab == 2 ? StepState.complete : StepState.indexed,
            content: Theme(
                data: Theme.of(context)
                    .copyWith(primaryColor: Theme.of(context).primaryColor),
                child: SignUpProfile())),
        Step(
            title: Text(translate(context, 'auth_step3'),
                style: Theme.of(context).textTheme.headline3),
            isActive: selectedTab >= 2,
            state: StepState.indexed,
            content: Theme(
                data: Theme.of(context)
                    .copyWith(primaryColor: Theme.of(context).primaryColor),
                child: SignUpVerification())),
      ];
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(translate(context, 'auth_register_label'),
              style: Theme.of(context).textTheme.headline2),
        ),
        body: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: Consumer2<SignUpProvider, ErrorNotifierProvider>(
              builder: (context, signup, errorProvider, child) =>
                  new Stack(children: <Widget>[
                    new Form(
                        child: Theme(
                            data: Theme.of(context).copyWith(
                                primaryColor:
                                    Theme.of(context).secondaryHeaderColor),
                            child: Stepper(
                              steps: buildSteps(signup.selectedTab),
                              type: StepperType.horizontal,
                              currentStep: signup.selectedTab,
                              controlsBuilder: (BuildContext context,
                                      {VoidCallback onStepContinue,
                                      VoidCallback onStepCancel}) =>
                                  Container(),
                              onStepTapped: (index) {
                                if (signup.selectedTab != 2)
                                  Provider.of<SignUpProvider>(context,
                                          listen: false)
                                      .setSelectedTab(index);
                              },
                            ))),
                    GenericError(errorProvider: errorProvider),
                  ])),
        ));
  }
}
