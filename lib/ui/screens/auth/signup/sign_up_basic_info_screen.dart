import 'package:acudia/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpBasicInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      TextFormField(
        keyboardType: TextInputType.text,
        autocorrect: false,
        onSaved: (String value) {},
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty || value.length < 1) {
            return translate(context, 'field_name_validation_empty');
          }
        },
        decoration: new InputDecoration(
            labelText: translate(context, 'field_name_label'),
            hintText: translate(context, 'field_name_hint'),
            //filled: true,
            icon: const Icon(Icons.person),
            labelStyle:
                new TextStyle(decorationStyle: TextDecorationStyle.solid)),
      ),
      SizedBox(height: 24),
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        onSaved: (String value) {},
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty || value.length < 1) {
            return translate(context, 'field_email_validation_empty');
          }
        },
        decoration: new InputDecoration(
            labelText: translate(context, 'field_email_label'),
            hintText: translate(context, 'field_email_hint'),
            //filled: true,
            icon: const Icon(Icons.mail),
            labelStyle:
                new TextStyle(decorationStyle: TextDecorationStyle.solid)),
      ),
      SizedBox(height: 24),
      TextFormField(
        keyboardType: TextInputType.text,
        autocorrect: false,
        onSaved: (String value) {},
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty || value.length < 1) {
            return translate(context, 'field_password_validation_empty');
          }
        },
        decoration: new InputDecoration(
            labelText: translate(context, 'field_password_label'),
            hintText: translate(context, 'field_password_hint'),
            icon: const Icon(Icons.lock),
            labelStyle:
                new TextStyle(decorationStyle: TextDecorationStyle.solid)),
      ),
      SizedBox(height: 24),
      Container(
        width: MediaQuery.of(context).size.width,
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("${translate(context, 'field_gender_label')}:"),
              SizedBox(height: 32),
            ]),
      ),
      ToggleButtons(
        children: <Widget>[
          Container(
            width: (MediaQuery.of(context).size.width - 52) / 3,
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(translate(context, 'field_gender_male')),
                ]),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 52) / 3,
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(translate(context, 'field_gender_female')),
                ]),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 52) / 3,
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(translate(context, 'field_gender_other')),
                ]),
          ),
        ],
        onPressed: (int index) {},
        isSelected: [false, false, false],
      ),
      SizedBox(height: 48),
      Container(
        width: MediaQuery.of(context).size.width,
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                  "${translate(context, 'next')}: ${translate(context, 'auth_step2')}"),
              Icon(Icons.arrow_forward),
            ]),
      ),
    ]);
  }
}
