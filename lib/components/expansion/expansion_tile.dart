import 'package:flutter/material.dart';

class AcudiaExpansionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  const AcudiaExpansionTile({Key key, this.title, this.subtitle, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {},
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text('Item 1'),
            );
          },
          body: ListTile(
            title: Text('Item 1 child'),
            subtitle: Text('Details goes here'),
          ),
          isExpanded: true,
        ),
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text('Item 2'),
            );
          },
          body: ListTile(
            title: Text('Item 2 child'),
            subtitle: Text('Details goes here'),
          ),
          isExpanded: false,
        ),
      ],
    );
  }
}
