import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/providers/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class SignUpBasicInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Consumer<SignUpProvider>(
        builder: (context, signup, child) => Column(children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                maxLines: 1,
                initialValue: signup.values[FIELD_NAME],
                onChanged: (text) {
                  Provider.of<SignUpProvider>(context, listen: false)
                      .updateValue(FIELD_NAME, text);
                },
                validator: MultiValidator([
                  RequiredValidator(
                      errorText:
                          translate(context, 'field_name_validation_empty')),
                  MaxLengthValidator(32,
                      errorText: translate(
                          context, 'field_name_validation_max_length')),
                ]),
                decoration: new InputDecoration(
                    labelText: translate(context, 'field_name_label'),
                    hintText: translate(context, 'field_name_hint'),
                    icon: const Icon(Icons.person),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid)),
              ),
              SizedBox(height: 24),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                maxLines: 1,
                initialValue: signup.values[FIELD_EMAIL],
                onChanged: (text) {
                  Provider.of<SignUpProvider>(context, listen: false)
                      .updateValue(FIELD_EMAIL, text);
                },
                validator: MultiValidator([
                  RequiredValidator(
                      errorText:
                          translate(context, 'field_email_validation_empty')),
                  EmailValidator(
                      errorText:
                          translate(context, 'field_email_validation_email')),
                ]),
                decoration: new InputDecoration(
                    labelText: translate(context, 'field_email_label'),
                    hintText: translate(context, 'field_email_hint'),
                    icon: const Icon(Icons.mail),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid)),
              ),
              SizedBox(height: 24),
              TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                maxLines: 1,
                initialValue: signup.values[FIELD_PASSWORD],
                obscureText: true,
                onChanged: (text) {
                  Provider.of<SignUpProvider>(context, listen: false)
                      .updateValue(FIELD_PASSWORD, text);
                },
                validator: MultiValidator([
                  RequiredValidator(
                      errorText: translate(
                          context, 'field_password_validation_empty')),
                  MinLengthValidator(8,
                      errorText: translate(
                          context, 'field_password_validation_minlength')),
                  PatternValidator(r'(?=.*?[0-9])',
                      errorText: translate(
                          context, 'field_password_validation_digits')),
                  PatternValidator(r'(?=.*?[A-Z])',
                      errorText: translate(
                          context, 'field_password_validation_upper')),
                  PatternValidator(r'(?=.*?[a-z])',
                      errorText: translate(
                          context, 'field_password_validation_lower')),
                ]),
                decoration: new InputDecoration(
                    labelText: translate(context, 'field_password_label'),
                    hintText: translate(context, 'field_password_hint'),
                    icon: const Icon(Icons.lock),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid)),
              ),
              SizedBox(height: 48),
              Container(
                width: MediaQuery.of(context).size.width,
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () {
                          if (!Form.of(context).validate()) {
                            Provider.of<SignUpProvider>(context, listen: false)
                                .setSelectedTab(1);
                          }
                        },
                        child: new Text(
                            "${translate(context, 'next')}: ${translate(context, 'auth_step2')}"),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColor),
                    ]),
              ),
            ]));
  }
}
