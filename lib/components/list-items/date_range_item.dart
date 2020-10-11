import 'package:acudia/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AcudiaDateRangeItem extends StatelessWidget {
  final DateTime from;
  final DateTime to;
  final Function onTap;
  final List<Widget> children;
  final Color backgroundColor;

  const AcudiaDateRangeItem({Key key, this.onTap, this.from, this.to, this.children, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String fromMonth =
        DateFormat.MMM("es").format(from)[0].toUpperCase() + DateFormat.MMM("es").format(from).substring(1);

    String toMonth = DateFormat.MMM("es").format(to)[0].toUpperCase() + DateFormat.MMM("es").format(to).substring(1);

    return new GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
            color: backgroundColor,
            child: Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                child: Container(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Text('${normalizeTime(from.day)}', style: TextStyle(fontSize: 28)),
                          Text('$fromMonth ${from.year}', style: TextStyle(fontSize: 12)),
                          Text('|'),
                          Text('${normalizeTime(to.day)}', style: TextStyle(fontSize: 28)),
                          Text('$toMonth ${to.year}', style: TextStyle(fontSize: 12)),
                        ])),
                    SizedBox(width: 18),
                    VerticalDivider(width: 1, thickness: 1, color: Theme.of(context).accentColor),
                    SizedBox(width: 18),
                    Expanded(
                        flex: 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: children)),
                  ]),
                ))));
  }
}
