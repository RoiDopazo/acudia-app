import 'package:acudia/app_localizations.dart';
import 'package:acudia/components/animation/animation_opacity.dart';
import 'package:acudia/components/navigation/floating_action_button_full.dart';
import 'package:acudia/components/pickers/date_picker.dart';
import 'package:acudia/components/pickers/number_picker.dart';
import 'package:acudia/components/pickers/time_picker.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/providers/assignment_provider.dart';
import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:acudia/core/services/assignments/assignments_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';

class HospitalAssignmentsConfigPage extends StatelessWidget {
  final Hospital hospital;
  final Function refetch;

  const HospitalAssignmentsConfigPage({Key key, this.hospital, this.refetch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(hospital.name);
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
                            hospital.province,
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
                  date: assingmentsProvider.assignmentItem.from,
                  label: translate(context, 'start_date'),
                  onChange: (value) =>
                      Provider.of<AssignmentsProvider>(context, listen: false)
                          .updateFromDate(value),
                ),
                if (assingmentsProvider.assignmentItem.from != null)
                  AcudiaAnimationOpacity(
                    opacity: assingmentsProvider.assignmentItem.from != null
                        ? 1.0
                        : 0.0,
                    child: AcudiaDatePickerField(
                      date: assingmentsProvider.assignmentItem.to,
                      firstDate: assingmentsProvider.assignmentItem.from,
                      label: translate(context, 'end_date'),
                      onChange: (value) => Provider.of<AssignmentsProvider>(
                              context,
                              listen: false)
                          .updateToDate(value),
                    ),
                  ),
                if (assingmentsProvider.assignmentItem.to != null)
                  AcudiaAnimationOpacity(
                    opacity: assingmentsProvider.assignmentItem.to != null
                        ? 1.0
                        : 0.0,
                    child: AcudiaTimePickerField(
                      time: assingmentsProvider.assignmentItem.startHour,
                      label: translate(context, 'start_time'),
                      onChange: (value) => Provider.of<AssignmentsProvider>(
                              context,
                              listen: false)
                          .updateStartHour(value),
                    ),
                  ),
                if (assingmentsProvider.assignmentItem.startHour != null)
                  AcudiaAnimationOpacity(
                    opacity:
                        assingmentsProvider.assignmentItem.startHour != null
                            ? 1.0
                            : 0.0,
                    child: AcudiaTimePickerField(
                      time: assingmentsProvider.assignmentItem.endHour,
                      label: translate(context, 'end_time'),
                      onChange: (value) => Provider.of<AssignmentsProvider>(
                              context,
                              listen: false)
                          .updateEndHour(value),
                    ),
                  ),
                if (assingmentsProvider.assignmentItem.endHour != null)
                  AcudiaAnimationOpacity(
                      opacity:
                          assingmentsProvider.assignmentItem.endHour != null
                              ? 1.0
                              : 0.0,
                      child: AcudiaNumberPickerField(
                          label: translate(context, 'fare'),
                          number: assingmentsProvider.assignmentItem.fare,
                          onChange: (value) => Provider.of<AssignmentsProvider>(
                                  context,
                                  listen: false)
                              .updateFare(value))),
                if (assingmentsProvider.isEditting)
                  FlatButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Theme.of(context).errorColor,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {},
                      child: Text(
                          '${translate(context, 'remove')} ${translate(context, 'assignment').toLowerCase()}',
                          style:
                              TextStyle(color: Theme.of(context).errorColor))),
                SizedBox(height: 100),
              ]))),
              floatingActionButton: Mutation(
                options: MutationOptions(
                    documentNode: gql(GRAPHQL_ADD_ASSIGNMENT_MUTATION),
                    onCompleted: (dynamic resultData) async {
                      if (resultData != null) {
                        hideLoadingDialog();
                        print('aaaaaaaacabou');
                        await refetch();
                        Navigator.of(context).pop(true);
                      }
                    },
                    onError: (dynamic error) {
                      hideLoadingDialog();
                      print('error');
                      showUnexpectedError(context);
                    }),
                builder: (
                  RunMutation runMutation,
                  QueryResult result,
                ) {
                  if (assingmentsProvider.assignmentItem.fare != null)
                    return AcudiaAnimationOpacity(
                        opacity: assingmentsProvider.assignmentItem.fare != null
                            ? 1.0
                            : 0.0,
                        child: AcudiaFloatingActionButtonFull(
                            onPressed: () {
                              showLoadingDialog();
                              DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                              runMutation({
                                "hospId": hospital.codCNH,
                                "hospName": hospital.name,
                                "hospProvince": hospital.province,
                                "email": "roidopazo@gmail.com",
                                "itemList": [
                                  {
                                    "from": dateFormat.format(
                                        assingmentsProvider
                                            .assignmentItem.from),
                                    "to": dateFormat.format(
                                        assingmentsProvider.assignmentItem.to),
                                    "startHour": assingmentsProvider
                                                .assignmentItem.startHour.hour *
                                            3600 +
                                        assingmentsProvider.assignmentItem
                                                .startHour.minute *
                                            60,
                                    "endHour": assingmentsProvider
                                                .assignmentItem.endHour.hour *
                                            3600 +
                                        assingmentsProvider
                                                .assignmentItem.endHour.minute *
                                            60,
                                    "fare":
                                        assingmentsProvider.assignmentItem.fare
                                  }
                                ]
                              });
                            },
                            text: assingmentsProvider.isEditting
                                ? '${translate(context, 'update')} ${translate(context, 'assignment').toLowerCase()}'
                                : '${translate(context, 'save')} ${translate(context, 'assignment').toLowerCase()}',
                            icon: Icon(Icons.save)));
                  return Container();
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ));
  }
}
