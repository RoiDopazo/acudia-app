import 'package:acudia/utils/constants.dart';
import 'package:flutter/material.dart';

class AcudiaRangeNumberPickerField extends StatelessWidget {
  final RangeValues rangeValues;
  final String label;
  final Function onChange;

  String normalizeTime(time) {
    String timeString = time.toString();

    if (time < 10) {
      timeString = '0$timeString';
    }
    return timeString;
  }

  const AcudiaRangeNumberPickerField({Key key, this.rangeValues, this.onChange, this.label = ''}) : super(key: key);

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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              onPressed: () {},
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                          Text('Entre:'),
                          SizedBox(width: 8),
                          Text(rangeValues.start.toStringAsFixed(2),
                              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18)),
                          SizedBox(width: 2),
                          Text('€/h'),
                          SizedBox(width: 4),
                          Text('y'),
                          SizedBox(width: 4),
                          Text(rangeValues.end.toStringAsFixed(2),
                              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18)),
                          SizedBox(width: 2),
                          Text('€/h')
                        ]))
                  ],
                ),
              ),
              color: Colors.white,
            ),
            RangeSlider(
              values: rangeValues,
              min: minFare,
              max: maxFare,
              divisions: 80,
              labels: RangeLabels(
                rangeValues.start.toStringAsFixed(2),
                rangeValues.end.toStringAsFixed(2),
              ),
              onChanged: (RangeValues values) {
                onChange(values);
              },
            ),
          ],
        ),
      ),
    );
  }
}
