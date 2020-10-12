import 'package:flutter/material.dart';

const DEFAULT_NUMBER = 10;

class AcudiaNumberPickerField extends StatelessWidget {
  final double number;
  final String label;
  final Function onChange;

  String normalizeTime(time) {
    String timeString = time.toString();

    if (time < 10) {
      timeString = '0$timeString';
    }
    return timeString;
  }

  const AcudiaNumberPickerField({Key key, this.number, this.onChange, this.label = ''}) : super(key: key);

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
                          Text(number != null ? number.toStringAsFixed(2) : '-- , -- ',
                              style:
                                  TextStyle(color: Theme.of(context).primaryColor, fontSize: number != null ? 28 : 16)),
                          Text('€/h')
                        ]))
                  ],
                ),
              ),
              color: Colors.white,
            ),
            Slider(
              value: number,
              min: 4.0,
              max: 20.0,
              divisions: 80,
              label: number.toStringAsFixed(2),
              onChanged: (double value) {
                onChange(value);
              },
            )
          ],
        ),
      ),
    );
  }
}
