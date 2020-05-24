import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/providers/sign_up_provider.dart';
import 'package:acudia/ui/screens/auth/signup/sign_up_basic_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Step> buildSteps(selecteTab) {
      return [
        new Step(
            title: Text(translate(context, 'auth_step1'),
                style: Theme.of(context).textTheme.headline2),
            isActive: selecteTab >= 0,
            state: StepState.indexed,
            content: SignUpBasicInfo()),
        new Step(
            title: Text(translate(context, 'auth_step2'),
                style: Theme.of(context).textTheme.headline2),
            isActive: selecteTab >= 1,
            state: StepState.indexed,
            content: Text(translate(context, 'auth_step2'))),
        new Step(
            title: Text(translate(context, 'auth_step3'),
                style: Theme.of(context).textTheme.headline2),
            isActive: selecteTab >= 2,
            state: StepState.indexed,
            content: Text(translate(context, 'auth_step3'))),
      ];
    }

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          title: Text(translate(context, 'auth_register_label'),
              style: Theme.of(context).textTheme.headline3),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: Consumer<SignUpProvider>(
              builder: (context, signup, child) => new Stepper(
                    steps: buildSteps(signup.selectedTab),
                    type: StepperType.horizontal,
                    currentStep: signup.selectedTab,
                    controlsBuilder: (BuildContext context,
                            {VoidCallback onStepContinue,
                            VoidCallback onStepCancel}) =>
                        Container(),
                    onStepTapped: (index) {
                      Provider.of<SignUpProvider>(context, listen: false)
                          .setSelectedTab(index);
                    },
                  )),
        ));
  }
}
