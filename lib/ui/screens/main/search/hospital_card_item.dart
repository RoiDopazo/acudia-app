import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HospitalCard extends StatelessWidget {
  final String name;
  final String location;

  const HospitalCard({@required this.name, @required this.location});

  Container _tile(String title, String subtitle) => Container(
      height: 80,
      alignment: Alignment.center,
      child: ListTile(
        title: Text(title,
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            )),
        subtitle: Text(subtitle,
            maxLines: 2, style: TextStyle(color: Colors.grey[600])),
        leading: SvgPicture.asset('assets/media/icon_hospital.svg', height: 48),
      ));

  @override
  Widget build(BuildContext context) {
    return new Stack(children: [
      _tile(
        name,
        location,
      ),
      SizedBox(height: 40)
    ]);

    return Center(
        child: Card(
      margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: InkWell(
        splashColor: Theme.of(context).accentColor.withAlpha(60),
        onTap: () {
          print('Card tapped.');
        },
        child: Container(
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width - 32,
          height: 500,
          child: Text("$name"),
        ),
      ),
    ));
  }
}
