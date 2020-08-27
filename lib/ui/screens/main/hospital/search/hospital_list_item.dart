import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HospitalListItem extends StatelessWidget {
  final String name;
  final String location;

  const HospitalListItem({@required this.name, @required this.location});

  Container _tile(String title, String subtitle) => Container(
      height: 72,
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
    return new Column(children: [
      _tile(
        name,
        location,
      ),
      Divider(),
    ]);
  }
}
