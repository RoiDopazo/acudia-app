import 'package:acudia/app_localizations.dart';
import 'package:acudia/components/animation/animation_opacity.dart';
import 'package:acudia/components/navigation/floating_action_button_full.dart';
import 'package:acudia/components/pickers/date_picker.dart';
import 'package:acudia/components/pickers/number_picker.dart';
import 'package:acudia/components/pickers/time_picker.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/providers/assignment_provider.dart';
import 'package:acudia/core/services/assignments/assignments_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HospitalAssignmentsConfigPage extends StatelessWidget {
  final Hospital hospital;

  const HospitalAssignmentsConfigPage({Key key, this.hospital})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Consumer<AssignmentsProvider>(
        builder: (context, assingmentsProvider, child) => Scaffold(
              appBar: AppBar(
                  title: Text(
                      translate(
                          context, 'hospital_assignments_conf_appbar_title'),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Colors.white))),
              body: SafeArea(
                  child: SingleChildScrollView(
                      child: Column(children: [
                Container(
                    constraints: BoxConstraints.expand(
                        height: 80.0,
                        width: MediaQuery.of(context).size.width + 100),
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    color: Theme.of(context).backgroundColor,
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            hospital.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            hospital.municipallity,
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ])),
                Divider(
                  height: 1,
                  color: Theme.of(context).accentColor,
                  thickness: 2,
                ),
                SizedBox(height: 16),
                AcudiaDatePickerField(
                  date: assingmentsProvider.fromDate,
                  label: translate(context, 'start_date'),
                  onChange: (value) =>
                      Provider.of<AssignmentsProvider>(context, listen: false)
                          .updateFromDate(value),
                ),
                if (assingmentsProvider.fromDate != null)
                  AcudiaAnimationOpacity(
                    opacity: assingmentsProvider.fromDate != null ? 1.0 : 0.0,
                    child: AcudiaDatePickerField(
                      date: assingmentsProvider.toDate,
                      firstDate: assingmentsProvider.fromDate,
                      label: translate(context, 'end_date'),
                      onChange: (value) => Provider.of<AssignmentsProvider>(
                              context,
                              listen: false)
                          .updateToDate(value),
                    ),
                  ),
                if (assingmentsProvider.toDate != null)
                  AcudiaAnimationOpacity(
                    opacity: assingmentsProvider.toDate != null ? 1.0 : 0.0,
                    child: AcudiaTimePickerField(
                      time: assingmentsProvider.startHour,
                      label: translate(context, 'start_time'),
                      onChange: (value) => Provider.of<AssignmentsProvider>(
                              context,
                              listen: false)
                          .updateStartHour(value),
                    ),
                  ),
                if (assingmentsProvider.startHour != null)
                  AcudiaAnimationOpacity(
                    opacity: assingmentsProvider.startHour != null ? 1.0 : 0.0,
                    child: AcudiaTimePickerField(
                      time: assingmentsProvider.endHour,
                      label: translate(context, 'end_time'),
                      onChange: (value) => Provider.of<AssignmentsProvider>(
                              context,
                              listen: false)
                          .updateEndHour(value),
                    ),
                  ),
                if (assingmentsProvider.endHour != null)
                  AcudiaAnimationOpacity(
                      opacity: assingmentsProvider.endHour != null ? 1.0 : 0.0,
                      child: AcudiaNumberPickerField(
                          label: translate(context, 'fare'),
                          number: assingmentsProvider.fare,
                          onChange: (value) => Provider.of<AssignmentsProvider>(
                                  context,
                                  listen: false)
                              .updateFare(value))),
              ]))),
              floatingActionButton: Mutation(
                options: MutationOptions(
                    documentNode: gql(GRAPHQL_ADD_ASSIGNMENT_MUTATION),
                    onCompleted: (dynamic resultData) {
                      print(resultData);
                    },
                    onError: (dynamic error) {
                      print(error);
                    }),
                builder: (
                  RunMutation runMutation,
                  QueryResult result,
                ) {
                  if (assingmentsProvider.fare != null)
                    return AcudiaAnimationOpacity(
                        opacity: assingmentsProvider.fare != null ? 1.0 : 0.0,
                        child: AcudiaFloatingActionButtonFull(
                            onPressed: () {
                              DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                              runMutation({
                                "hospId": hospital.codCNH,
                                "hospName": hospital.name,
                                "hospProvince": hospital.province,
                                "email": "roidopazo@gmail.com",
                                "itemList": [
                                  {
                                    "from": dateFormat
                                        .format(assingmentsProvider.fromDate),
                                    "to": dateFormat
                                        .format(assingmentsProvider.toDate),
                                    "startHour": assingmentsProvider
                                                .startHour.hour *
                                            3600 +
                                        assingmentsProvider.startHour.minute *
                                            60,
                                    "endHour": assingmentsProvider
                                                .endHour.hour *
                                            3600 +
                                        assingmentsProvider.endHour.minute * 60,
                                    "fare": assingmentsProvider.fare
                                  }
                                ]
                              });
                            },
                            text: translate(
                                context, 'hospital_assignments_save_label'),
                            icon: Icon(Icons.save)));
                  return Container();
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ));
  }
}
