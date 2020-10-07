import 'package:acudia/app_localizations.dart';
import 'package:acudia/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class AcudiaTimePickerField extends StatelessWidget {
  final TimeOfDay time;
  final String label;
  final Function onChange;

  const AcudiaTimePickerField({Key key, this.time, this.onChange, this.label = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimeOfDay initDate = new TimeOfDay(hour: 0, minute: 0);

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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              elevation: 2.0,
              onPressed: () {
                showMaterialTimePicker(
                    context: context,
                    selectedTime: time == null ? initDate : time,
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
                                Icons.access_time,
                                size: 18.0,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                  time != null
                                      ? '${normalizeTime(time.hour)} : ${normalizeTime(time.minute)}'
                                      : translate(context, 'no_specified'),
                                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16))
                            ],
                          ),
                        )
                      ],
                    ),
                    time == null
                        ? Text(translate(context, 'select'),
                            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16))
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
