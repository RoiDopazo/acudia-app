import 'package:acudia/core/providers/assignment_provider.dart';
import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/ui/screens/main/hospital/assignments/hospital_assignments_config_page.dart';
import 'package:acudia/ui/screens/main/hospital/search/hospital_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HospitalAssignmentsAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AssignmentsProvider, HospitalProvider>(
        builder: (context, assignmentProvider, hospitalProvider, child) {
      switch (assignmentProvider.selectedTab) {
        case 0:
          return HospitalSearchPage(isAssignment: true);
        case 1:
          return HospitalAssignmentsConfigPage(
              hospital: hospitalProvider.selected);
        default:
          return null;
      }
    });
  }
}
