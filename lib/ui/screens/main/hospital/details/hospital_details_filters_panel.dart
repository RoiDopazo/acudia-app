import 'package:acudia/app_localizations.dart';
import 'package:acudia/components/pickers/date_picker.dart';
import 'package:acudia/components/pickers/range_number_picker.dart';
import 'package:acudia/components/pickers/time_picker.dart';
import 'package:acudia/core/providers/assignment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterPanel extends StatelessWidget {
  final ScrollController scrollController;

  const FilterPanel({@required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Consumer<AssignmentsProvider>(
        builder: (context, assignmentsProvider, child) => MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Container(
                margin: EdgeInsets.only(top: 16),
                child: ListView(
                  controller: this.scrollController,
                  children: <Widget>[
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(12.0))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          translate(context, "filters"),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 24.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AcudiaDatePickerField(
                            date: assignmentsProvider.assignment.from,
                            label: translate(context, 'start_date'),
                            onChange: (value) =>
                                Provider.of<AssignmentsProvider>(context, listen: false).updateFromDate(value),
                          ),
                          AcudiaDatePickerField(
                            date: assignmentsProvider.assignment.to,
                            firstDate: assignmentsProvider.assignment.from,
                            label: translate(context, 'end_date'),
                            onChange: (value) =>
                                Provider.of<AssignmentsProvider>(context, listen: false).updateToDate(value),
                          ),
                          AcudiaTimePickerField(
                            time: assignmentsProvider.assignment.startHour,
                            label: translate(context, 'start_time'),
                            onChange: (value) =>
                                Provider.of<AssignmentsProvider>(context, listen: false).updateStartHour(value),
                          ),
                          AcudiaTimePickerField(
                            time: assignmentsProvider.assignment.endHour,
                            label: translate(context, 'end_time'),
                            onChange: (value) =>
                                Provider.of<AssignmentsProvider>(context, listen: false).updateEndHour(value),
                          ),
                          AcudiaRangeNumberPickerField(
                            rangeValues: assignmentsProvider.rangeValues,
                            label: translate(context, 'fare'),
                            onChange: (values) =>
                                Provider.of<AssignmentsProvider>(context, listen: false).updateRangeValues(values),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ))));
  }
}
