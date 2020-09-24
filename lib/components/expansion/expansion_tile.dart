import 'package:flutter/material.dart';

class AcudiaExpansionTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const AcudiaExpansionTile({Key key, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        maxLines: 2,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.subtitle2),
      children: <Widget>[
        ListTile(
          title: Text('data'),
        )
      ],
    );
  }
}
