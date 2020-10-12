import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:acudia/core/entity/assignment_item_entity.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/providers/assignment_provider.dart';
import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/core/services/assignments/assignments_service.dart';
import 'package:acudia/ui/screens/main/hospital/assignments/hospital_assignments_add_page.dart';
import 'package:acudia/ui/screens/main/hospital/assignments/hospital_assignments_config_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'hospita_assignment_item.dart';

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

    return Consumer<HospitalProvider>(
        builder: (context, hospProvider, child) => Scaffold(
              appBar: AppBar(
                  title: Text(translate(context, 'hospital_assignments_appbar_title'),
                      style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white))),
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
                  if (assignmentList != null && assignmentList.length > 0) {
                    return SingleChildScrollView(
                        child: Column(children: [
                      SizedBox(height: 16),
                      for (Assignment assignment in assignmentList)
                        HospitalAssignmentItem(
                            title: assignment.hospName,
                            subtitle: '${assignment.hospProvince}',
                            items: assignment.itemList,
                            onTap: (AssignmentItem item, int index) {
                              Provider.of<AssignmentsProvider>(context).moveToConfig(true);
                              Provider.of<AssignmentsProvider>(context).setAssignmentItem(item, assignment);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HospitalAssignmentsConfigPage(
                                      hospital: new Hospital(
                                          codCNH: int.tryParse(assignment.hospId),
                                          name: assignment.hospName,
                                          province: assignment.hospProvince),
                                      assignment: assignment,
                                      index: index),
                                  fullscreenDialog: true,
                                ),
                              );
                            }),
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
