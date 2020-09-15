import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/providers/assignment_provider.dart';
import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/ui/screens/main/hospital/assignments/hospital_assignments_add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HospitalAssignmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emptyContent = Container(
        alignment: Alignment.center,
        child: Center(
            child: Text(
          translate(context, 'hospital_assignments_empty_content'),
          textAlign: TextAlign.center,
        )));

    return Consumer<HospitalProvider>(
        builder: (context, hospProvider, child) => Scaffold(
              appBar: AppBar(
                  title: Text(
                      translate(context, 'hospital_assignments_appbar_title'),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Colors.white))),
              body: emptyContent,
              floatingActionButton: FloatingActionButton.extended(
                  shape: StadiumBorder(
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  onPressed: () {
                    Provider.of<HospitalProvider>(context).cleanup();
                    Provider.of<AssignmentsProvider>(context).cleanup();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HospitalAssignmentsAddPage(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                  label: Text(
                      translate(context, 'hospital_assignments_new_label'),
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor),
            ));
  }
}
