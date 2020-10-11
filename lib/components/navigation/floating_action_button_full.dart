import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AcudiaFloatingActionButtonFull extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Widget icon;

  const AcudiaFloatingActionButtonFull({Key key, this.onPressed, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(minWidth: double.infinity, minHeight: 70),
        child: FloatingActionButton(
            shape: ContinuousRectangleBorder(),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: onPressed,
            isExtended: true,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
                  SizedBox(width: 8),
                  icon != null ? icon : null,
                ])));
  }
}
