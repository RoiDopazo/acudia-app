import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/providers/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';

class SignUpProfile extends StatelessWidget {
  // Future getImage() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  // }
  final time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    List<bool> role = Provider.of<SignUpProvider>(context).values[FIELD_ROLE];
    final isAcudier = role[1];

    final errorComponent = (signup, key) => Column(
          children: signup.errors[key] != ''
              ? [
                  SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      translate(context, signup.errors[key]),
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Theme.of(context).errorColor),
                    )
                  ])
                ]
              : [Container()],
        );

    return Consumer<SignUpProvider>(
        builder: (context, signup, child) => Column(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        translate(context, 'field_role_label'),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: 32),
                    ]),
              ),
              ToggleButtons(
                  onPressed: (int index) {
                    List<bool> roleValues = [false, false];
                    roleValues[index] = true;
                    Provider.of<SignUpProvider>(context, listen: false)
                        .updateValue(FIELD_ROLE, roleValues);
                  },
                  isSelected: signup.values[FIELD_ROLE],
                  children: <Widget>[
                    Container(
                      width: (MediaQuery.of(context).size.width - 52) / 3,
                      height: 80,
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(translate(context, 'field_role_client')),
                          ]),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 52) / 3,
                      height: 80,
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(translate(context, 'field_role_acudier')),
                          ]),
                    )
                  ]),
              errorComponent(signup, FIELD_ROLE),
              SizedBox(height: 16),
              Column(
                  children: isAcudier
                      ? ([
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      "${translate(context, 'field_gender_label')}:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                  SizedBox(height: 32),
                                ]),
                          ),
                          ToggleButtons(
                            isSelected: signup.values[FIELD_GENDER],
                            onPressed: (int index) {
                              List<bool> genderValues = [false, false, false];
                              genderValues[index] = true;
                              Provider.of<SignUpProvider>(context,
                                      listen: false)
                                  .updateValue(FIELD_GENDER, genderValues);
                            },
                            children: <Widget>[
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width - 52) /
                                        3,
                                child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(translate(
                                          context, 'field_gender_male')),
                                    ]),
                              ),
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width - 52) /
                                        3,
                                child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(translate(
                                          context, 'field_gender_female')),
                                    ]),
                              ),
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width - 52) /
                                        3,
                                child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(translate(
                                          context, 'field_gender_other')),
                                    ]),
                              )
                            ],
                          ),
                          errorComponent(signup, FIELD_GENDER),
                          SizedBox(height: 16),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      translate(
                                          context, 'field_birthdate_label'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                  SizedBox(height: 32),
                                ]),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: RaisedButton(
                                  elevation: 8,
                                  child: Text(translate(context, 'select')),
                                  onPressed: () => showMaterialDatePicker(
                                      context: context,
                                      firstDate: new DateTime(1900),
                                      lastDate: new DateTime.now(),
                                      selectedDate:
                                          signup.values[FIELD_BIRTHDATE] != null
                                              ? signup.values[FIELD_BIRTHDATE]
                                              : new DateTime.now(),
                                      onChanged: (value) =>
                                          Provider.of<SignUpProvider>(context,
                                                  listen: false)
                                              .updateValue(
                                                  FIELD_BIRTHDATE, value)),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  signup.values[FIELD_BIRTHDATE] != null
                                      ? DateFormat.yMMMd().format(
                                          signup.values[FIELD_BIRTHDATE])
                                      : 'Sin especificar',
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          errorComponent(signup, FIELD_ROLE),
                        ])
                      : [Container()]),
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width,
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(translate(context, 'field_picture_label'),
                          style: Theme.of(context).textTheme.headline4),
                      Text(' ('),
                      !isAcudier
                          ? Text(translate(context, 'optional'))
                          : Text(translate(context, 'recommendable')),
                      Text(')'),
                      SizedBox(height: 32),
                    ]),
              ),
              SizedBox(height: 48),
              Container(
                width: MediaQuery.of(context).size.width,
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () {
                          if (Provider.of<SignUpProvider>(context,
                                  listen: false)
                              .validate()) {
                            Provider.of<SignUpProvider>(context, listen: false)
                                .signUp(context);
                          }
                        },
                        child: new Text(
                            "${translate(context, 'next')}: ${translate(context, 'auth_step3')}",
                            style: Theme.of(context).textTheme.headline3),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).appBarTheme.color),
                    ]),
              ),
            ]));
  }
}
