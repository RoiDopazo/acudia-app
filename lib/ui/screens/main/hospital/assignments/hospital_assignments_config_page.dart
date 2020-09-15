import 'package:acudia/app_localizations.dart';
import 'package:acudia/components/animation/animation_opacity.dart';
import 'package:acudia/components/navigation/floating_action_button_full.dart';
import 'package:acudia/components/pickers/date_picker.dart';
import 'package:acudia/components/pickers/number_picker.dart';
import 'package:acudia/components/pickers/time_picker.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/providers/assignment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                AcudiaAnimationOpacity(
                  opacity: assingmentsProvider.fromDate != null ? 1.0 : 0.0,
                  child: AcudiaDatePickerField(
                    date: assingmentsProvider.toDate,
                    firstDate: assingmentsProvider.fromDate,
                    label: translate(context, 'end_date'),
                    onChange: (value) =>
                        Provider.of<AssignmentsProvider>(context, listen: false)
                            .updateToDate(value),
                  ),
                ),
                AcudiaAnimationOpacity(
                  opacity: assingmentsProvider.toDate != null ? 1.0 : 0.0,
                  child: AcudiaTimePickerField(
                    time: assingmentsProvider.startHour,
                    label: translate(context, 'start_time'),
                    onChange: (value) =>
                        Provider.of<AssignmentsProvider>(context, listen: false)
                            .updateStartHour(value),
                  ),
                ),
                AcudiaAnimationOpacity(
                  opacity: assingmentsProvider.startHour != null ? 1.0 : 0.0,
                  child: AcudiaTimePickerField(
                    time: assingmentsProvider.endHour,
                    label: translate(context, 'end_time'),
                    onChange: (value) =>
                        Provider.of<AssignmentsProvider>(context, listen: false)
                            .updateEndHour(value),
                  ),
                ),
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
              floatingActionButton: AcudiaAnimationOpacity(
                  opacity: assingmentsProvider.fare != null ? 1.0 : 0.0,
                  child: AcudiaFloatingActionButtonFull(
                      text:
                          translate(context, 'hospital_assignments_save_label'),
                      icon: Icon(Icons.save))),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ));
  }
}
