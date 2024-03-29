import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/providers/search_provider.dart';
import 'package:acudia/routes.dart';
import 'package:acudia/ui/screens/main/hospital/details/hospital_details_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HospitalListItem extends StatelessWidget {
  final Hospital hospital;
  final bool isAssigment;
  final bool isSelected;

  const HospitalListItem({@required this.hospital, this.isSelected = false, this.isAssigment});

  Container _tile(BuildContext context, String title, String subtitle, bool isSelected) => Container(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
      height: 84,
      alignment: Alignment.center,
      color: isSelected ? Theme.of(context).primaryColor.withAlpha(50) : Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        onTap: () {
          if (isAssigment) {
            Provider.of<SearchProvider>(context, listen: false).setSelectedHospital(hospital);
          } else {
            Navigator.pushNamed(
              context,
              Routes.HOSP_DETAILS,
              arguments: HospitalArguments(hospital: hospital),
            );
          }
        },
        title: Text(title,
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            )),
        subtitle: Text(subtitle, maxLines: 2, style: TextStyle(color: Colors.grey[600])),
        leading: SvgPicture.asset('assets/media/icon_hospital.svg', height: 48),
      ));

  @override
  Widget build(BuildContext context) {
    return new Column(children: [
      _tile(context, hospital.name, "${hospital.municipallity} - ${hospital.province}", isSelected),
      Divider(height: 1),
    ]);
  }
}
