import 'package:acudia/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

const DEFAULT_NUMBER = 10;

class AcudiaNumberPickerField extends StatelessWidget {
  final int number;
  final String label;
  final Function onChange;

  String normalizeTime(time) {
    String timeString = time.toString();

    if (time < 10) {
      timeString = '0$timeString';
    }
    return timeString;
  }

  const AcudiaNumberPickerField(
      {Key key, this.number, this.onChange, this.label = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                alignment: Alignment.centerLeft,
                child: label != null ? Text(label) : Text('')),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              onPressed: () {
                showMaterialNumberPicker(
                    context: context,
                    minNumber: 1,
                    title: '$label (${translate(context, 'euro_hour')})',
                    maxNumber: 50,
                    headerTextColor: Colors.white,
                    selectedNumber: number == null ? DEFAULT_NUMBER : number,
                    onChanged: (value) => onChange(value));
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                          Text(number != null ? '$number,00 ' : '-- , -- ',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: number != null ? 28 : 16)),
                          Text('€/h')
                        ]))
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
