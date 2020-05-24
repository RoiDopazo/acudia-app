import 'package:acudia/app_localizations.dart';
import 'package:acudia/ui/screens/auth/signup/sign_up_basic_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      new Step(
          title: Text(translate(context, 'auth_step1'),
              style: Theme.of(context).textTheme.headline2),
          isActive: true,
          state: StepState.indexed,
          content: SignUpBasicInfo()),
      new Step(
          title: Text(translate(context, 'auth_step2'),
              style: Theme.of(context).textTheme.headline2),
          isActive: false,
          state: StepState.indexed,
          content: SignUpBasicInfo()),
      new Step(
          title: Text(translate(context, 'auth_step3'),
              style: Theme.of(context).textTheme.headline2),
          isActive: false,
          state: StepState.indexed,
          content: SignUpBasicInfo()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(translate(context, 'Registration')),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: new Stepper(
            steps: steps,
            type: StepperType.horizontal,
            currentStep: 0,
            controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
                Container(),
          )),
    );
  }
}
