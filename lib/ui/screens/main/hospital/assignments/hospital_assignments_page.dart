import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/providers/assignment_provider.dart';
import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/core/services/assignments/assignments_service.dart';
import 'package:acudia/ui/screens/main/hospital/assignments/hospital_assignments_add_page.dart';
import 'package:acudia/ui/screens/main/hospital/assignments/hospital_assignments_config_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'hospital_assignment_item.dart';

class HospitalAssignmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emptyContent = Padding(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Container(
            alignment: Alignment.center,
            child: Center(
                child: Text(
              translate(context, 'hospital_assignments_empty_content'),
              textAlign: TextAlign.center,
            ))));

    return Consumer2<HospitalProvider, ProfileProvider>(
        builder: (context, hospProvider, profileProvider, child) => Scaffold(
              body: SafeArea(
                  child: Query(
                options: QueryOptions(
                  documentNode: gql(GRAPHQL_GET_MY_ASSIGNMENTS_QUERY),
                ),
                builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }

                  if (result.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  Provider.of<AssignmentsProvider>(context).setRefetchFunc(refetch);

                  List<Assignment> assignmentList = Assignment.fromJsonList(result.data['getMyAssignments']['items']);

                  Map<String, List<Assignment>> assignmentMap = new Map();
                  assignmentList.forEach((Assignment element) {
                    if (assignmentMap[element.hospId] == null) {
                      assignmentMap[element.hospId] = [element];
                    } else {
                      assignmentMap[element.hospId].add(element);
                    }
                  });

                  if (assignmentList != null && assignmentList.length > 0) {
                    return SingleChildScrollView(
                        child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Row(
                                children: [
                                  Text('Hola ', style: TextStyle(fontSize: 32)),
                                  Text(profileProvider.profile.name,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(fontSize: 32, color: Theme.of(context).primaryColor)),
                                  Text(',', style: TextStyle(fontSize: 32)),
                                ],
                              ),
                              Text("Estas son tus asignaciones", style: TextStyle(fontSize: 22))
                            ])),
                      ),
                      SizedBox(height: 16),
                      for (MapEntry<String, List<Assignment>> assignment in assignmentMap.entries)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: HospitalAssignmentItem(
                              title: assignment.value[0].hospName,
                              subtitle: '${assignment.value[0].hospProvince}',
                              items: assignment.value,
                              onTap: (Assignment item, int index) {
                                Provider.of<AssignmentsProvider>(context).moveToConfig(true);
                                Provider.of<AssignmentsProvider>(context).setAssignment(item);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HospitalAssignmentsConfigPage(
                                        hospital: new Hospital(
                                            codCNH: int.tryParse(assignment.key),
                                            name: assignment.value[0].hospName,
                                            province: assignment.value[0].hospProvince),
                                        assignment: assignment.value[0],
                                        index: index),
                                    fullscreenDialog: true,
                                  ),
                                );
                              }),
                        ),
                      SizedBox(height: 24)
                    ]));
                  } else {
                    return emptyContent;
                  }
                },
              )),
              floatingActionButton: FloatingActionButton(
                  shape: StadiumBorder(side: BorderSide(color: Theme.of(context).primaryColor)),
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
                  child: Icon(Icons.add, color: Theme.of(context).scaffoldBackgroundColor),
                  backgroundColor: Theme.of(context).primaryColor),
            ));
  }
}
