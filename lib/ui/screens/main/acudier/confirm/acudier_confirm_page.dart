import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/entity/profile_entity.dart';
import 'package:acudia/core/providers/availability_provider.dart';
import 'package:acudia/routes.dart';
import 'package:acudia/ui/screens/main/acudier/confirm/acudier_confirm_args.dart';
import 'package:acudia/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AcudierConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AcudierConfirmArguments args = ModalRoute.of(context).settings.arguments;
    final Profile acudier = args.acudier;
    final Hospital hospital = args.hospital;

    DateFormat dateFormat = DateFormat("d MMM");
    DateFormat dateFormat2 = DateFormat("y");

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: BackButton(color: Theme.of(context).accentColor),
          elevation: 0,
          title: Text("Confirmar solicitud"),
        ),
        body: Consumer<AvailabilityProvider>(
          builder: (context, availability, child) => Column(children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(children: [
              Container(
                  child: Text('${acudier.name} ${acudier.secondName}',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ))),
              Container(
                  child: Text(
                      translate(context, 'computed_age')
                          .replaceAll('{{ age }}', calculateAge(acudier.birthDate).toString()),
                      style: TextStyle(
                        fontSize: 14.0,
                      ))),
              SizedBox(height: 24),
              Divider(height: 4, thickness: 1),
              SizedBox(height: 24),
              Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Container(
                        width: MediaQuery.of(context).size.width - 96,
                        child: Text(hospital.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ))),
                    SvgPicture.asset('assets/media/icon_hospital.svg', height: 48),
                  ])),
              Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: [
                        Text(hospital.healthCarePurpose),
                        Text(' · '),
                        Text(hospital.province),
                        Text(' · '),
                        Text(hospital.state)
                      ],
                    ),
                  )),
              SizedBox(height: 24),
              Divider(height: 4, thickness: 1),
              SizedBox(height: 24),
              Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Theme.of(context).accentColor,
                      )),
                  child: Column(
                    children: [
                      Text(dateFormat.format(availability.startDate).toUpperCase(),
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                      Text(dateFormat2.format(availability.startDate))
                    ],
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    margin: EdgeInsets.only(right: 48),
                    child: Text(
                      '${normalizeTime(availability.startHour.hour)}:${normalizeTime(availability.startHour.minute)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )),
                Container(
                    child: Column(
                  children: [
                    for (int i in [1, 2, 3, 4, 5, 6, 7, 8])
                      Container(
                        decoration: BoxDecoration(color: Theme.of(context).accentColor, shape: BoxShape.circle),
                        margin: EdgeInsets.all(4),
                        width: 10,
                        height: 10,
                      ),
                  ],
                )),
                Container(
                    margin: EdgeInsets.only(left: 48),
                    child: Text(
                        '${normalizeTime(availability.endHour.hour)}:${normalizeTime(availability.endHour.minute)}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
              ]),
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Theme.of(context).accentColor,
                      )),
                  child: Column(
                    children: [
                      Text(dateFormat.format(availability.endDate).toUpperCase(),
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                      Text(dateFormat2.format(availability.endDate))
                    ],
                  )),
              SizedBox(height: 24),
              Divider(height: 4, thickness: 1),
              SizedBox(height: 24),
              Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Row(children: [
                    Text(translate(context, "total_price"),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                    Text("${availability.price} €", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                  ])),
              SizedBox(height: 24),
              Container(
                  width: MediaQuery.of(context).size.width - 48,
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                    textColor: Theme.of(context).backgroundColor,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, Routes.MAIN, (route) => false);
                    },
                    child: new Text(translate(context, 'do_request')),
                  ))
            ]))),
          ]),
        ));
  }
}
