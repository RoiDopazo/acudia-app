import 'dart:io';
import 'package:acudia/app_localizations.dart';
import 'package:acudia/components/animation/animation_opacity.dart';
import 'package:acudia/components/navigation/floating_action_button_full.dart';
import 'package:acudia/components/pickers/date_picker.dart';
import 'package:acudia/components/pickers/number_picker.dart';
import 'package:acudia/components/pickers/time_picker.dart';
import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/providers/assignment_provider.dart';
import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:acudia/core/services/assignments/assignments_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';

class HospitalAssignmentsConfigPage extends StatelessWidget {
  final Hospital hospital;
  Assignment assignment;
  final int index;

  HospitalAssignmentsConfigPage({Key key, this.hospital, this.index, this.assignment}) : super(key: key);

  refetchData(assingmentsProvider) async {
    try {
      await assingmentsProvider.refetch();
      print('works');
    } catch (err) {
      // FIXME!!!!
      print(err);
      if (err.message == 'Query is not refetch safe') {
        sleep(const Duration(seconds: 1));
        refetchData(assingmentsProvider);
      }
    }
  }

  Widget floatingActionButton(AssignmentsProvider assingmentsProvider, context) {
    return Mutation(
      options: MutationOptions(
          documentNode: gql(
              assingmentsProvider.isEditting ? GRAPHQL_UPDATE_ASSIGNMENT_MUTATION : GRAPHQL_ADD_ASSIGNMENT_MUTATION),
          onCompleted: (dynamic resultData) async {
            if (resultData != null) {
              hideLoadingDialog();
              await refetchData(assingmentsProvider);
              Navigator.of(context).pop(true);
            }
          },
          onError: (dynamic error) {
            hideLoadingDialog();
            showUnexpectedError(context);
          }),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        if (assingmentsProvider.assignment.fare != null)
          return AcudiaAnimationOpacity(
              opacity: assingmentsProvider.assignment.fare != null ? 1.0 : 0.0,
              child: AcudiaFloatingActionButtonFull(
                  onPressed: () {
                    showLoadingDialog();
                    if (assingmentsProvider.isEditting) {
                      assignment.from = assingmentsProvider.assignment.from;
                      assignment.to = assingmentsProvider.assignment.to;
                      assignment.startHour = assingmentsProvider.assignment.startHour;
                      assignment.endHour = assingmentsProvider.assignment.endHour;
                      assignment.fare = assingmentsProvider.assignment.fare;
                      runMutation(assignment.toJson());
                    } else {
                      runMutation({
                        ...assingmentsProvider.assignment.toJson(),
                        "hospId": hospital.codCNH.toString(),
                        "hospName": hospital.name,
                        "hospProvince": hospital.province,
                      });
                    }
                  },
                  text: assingmentsProvider.isEditting
                      ? '${translate(context, 'update')} ${translate(context, 'assignment').toLowerCase()}'
                      : '${translate(context, 'save')} ${translate(context, 'assignment').toLowerCase()}',
                  icon: Icon(Icons.save)));
        return Container();
      },
    );
  }

  Widget removeAssignmentWidget(AssignmentsProvider assingmentsProvider, context) {
    return Mutation(
      options: MutationOptions(
          documentNode: gql(GRAPHQL_REMOVE_ASSIGNMENTS_MUTATION),
          onCompleted: (dynamic resultData) async {
            if (resultData != null) {
              hideLoadingDialog();
              await refetchData(assingmentsProvider);
              Navigator.of(context).pop(true);
            }
          },
          onError: (dynamic error) {
            hideLoadingDialog();
            showUnexpectedError(context);
          }),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return FlatButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).errorColor, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8)),
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.WARNING,
                animType: AnimType.SCALE,
                title: translate(context, 'hospital_assignment_remove_question'),
                desc: "",
                btnCancelOnPress: () {},
                btnOkOnPress: () async {
                  showLoadingDialog();
                  runMutation(assignment.toJson());
                },
              )..show();
            },
            child: Text('${translate(context, 'remove')} ${translate(context, 'assignment').toLowerCase()}',
                style: TextStyle(color: Theme.of(context).errorColor)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Consumer<AssignmentsProvider>(
        builder: (context, assingmentsProvider, child) => Scaffold(
              appBar: AppBar(
                  title: Text(translate(context, 'hospital_assignments_conf_appbar_title'),
                      style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white))),
              body: SafeArea(
                  child: SingleChildScrollView(
                      child: Column(children: [
                Container(
                    constraints: BoxConstraints.expand(height: 80.0, width: MediaQuery.of(context).size.width + 100),
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    color: Theme.of(context).backgroundColor,
                    alignment: Alignment.center,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  date: assingmentsProvider.assignment.from,
                  label: translate(context, 'start_date'),
                  onChange: (value) => Provider.of<AssignmentsProvider>(context, listen: false).updateFromDate(value),
                ),
                if (assingmentsProvider.assignment.from != null)
                  AcudiaAnimationOpacity(
                    opacity: assingmentsProvider.assignment.from != null ? 1.0 : 0.0,
                    child: AcudiaDatePickerField(
                      date: assingmentsProvider.assignment.to,
                      firstDate: assingmentsProvider.assignment.from,
                      label: translate(context, 'end_date'),
                      onChange: (value) => Provider.of<AssignmentsProvider>(context, listen: false).updateToDate(value),
                    ),
                  ),
                if (assingmentsProvider.assignment.to != null)
                  AcudiaAnimationOpacity(
                    opacity: assingmentsProvider.assignment.to != null ? 1.0 : 0.0,
                    child: AcudiaTimePickerField(
                      time: assingmentsProvider.assignment.startHour,
                      label: translate(context, 'start_time'),
                      onChange: (value) =>
                          Provider.of<AssignmentsProvider>(context, listen: false).updateStartHour(value),
                    ),
                  ),
                if (assingmentsProvider.assignment.startHour != null)
                  AcudiaAnimationOpacity(
                    opacity: assingmentsProvider.assignment.startHour != null ? 1.0 : 0.0,
                    child: AcudiaTimePickerField(
                      time: assingmentsProvider.assignment.endHour,
                      label: translate(context, 'end_time'),
                      onChange: (value) =>
                          Provider.of<AssignmentsProvider>(context, listen: false).updateEndHour(value),
                    ),
                  ),
                if (assingmentsProvider.assignment.endHour != null)
                  AcudiaAnimationOpacity(
                      opacity: assingmentsProvider.assignment.endHour != null ? 1.0 : 0.0,
                      child: AcudiaNumberPickerField(
                          label: translate(context, 'fare'),
                          number: assingmentsProvider.assignment.fare,
                          onChange: (value) =>
                              Provider.of<AssignmentsProvider>(context, listen: false).updateFare(value))),
                if (assingmentsProvider.isEditting) removeAssignmentWidget(assingmentsProvider, context),
                SizedBox(height: 100),
              ]))),
              floatingActionButton: floatingActionButton(assingmentsProvider, context),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            ));
  }
}
