import 'package:acudia/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:intl/intl.dart';

class AcudiaDatePickerField extends StatelessWidget {
  final DateTime date;
  final DateTime firstDate;
  final String label;
  final Function onChange;

  const AcudiaDatePickerField(
      {Key key, this.date, this.onChange, this.label = '', this.firstDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = firstDate != null ? firstDate : new DateTime.now();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                alignment: Alignment.centerLeft,
                child: label != null ? Text(label) : Text('')),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 2.0,
              onPressed: () {
                showMaterialDatePicker(
                    context: context,
                    firstDate: now,
                    lastDate: now.add(new Duration(days: 365)),
                    selectedDate: date == null ? now : date,
                    onChanged: (value) => onChange(value));
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                size: 18.0,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                  date != null
                                      ? DateFormat.yMMMd('en').format(date)
                                      : translate(context, 'no_specified'),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16))
                            ],
                          ),
                        )
                      ],
                    ),
                    date == null
                        ? Text(translate(context, 'select'),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16))
                        : Icon(
                            Icons.edit,
                            size: 18.0,
                            color: Theme.of(context).primaryColor,
                          ),
                  ],
                ),
              ),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
