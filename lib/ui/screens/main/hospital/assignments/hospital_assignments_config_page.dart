import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HospitalAssignmentsConfigPage extends StatelessWidget {
  final Hospital hospital;

  HospitalAssignmentsConfigPage({@required this.hospital});

  @override
  Widget build(BuildContext context) {
    final emptyContent = Container(
        alignment: Alignment.center,
        child: Center(
            child: Text(
          translate(context, 'hospital_assignments_empty_content'),
          textAlign: TextAlign.center,
        )));

    // return Consumer<HospitalProvider>(
    //     builder: (context, hospProvider, child) => Scaffold()
  }
}
