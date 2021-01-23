import 'package:flutter/material.dart';

class AcudiaDataItem extends StatelessWidget {
  final String label;
  final String value;

  const AcudiaDataItem({Key key, @required this.label, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      SizedBox(height: 8),
      Text(value, style: TextStyle(fontSize: 16)),
      SizedBox(height: 16),
      Divider(height: 1, thickness: 1, indent: 0, endIndent: 8),
      SizedBox(height: 16),
    ]);
  }
}
