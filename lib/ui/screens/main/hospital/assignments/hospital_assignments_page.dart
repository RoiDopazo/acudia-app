import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/providers/assignment_provider.dart';
import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/core/services/assignments/assignments_service.dart';
import 'package:acudia/ui/screens/main/hospital/assignments/hospital_assignments_add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';

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
                  title: Text(
                      translate(context, 'hospital_assignments_appbar_title'),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Colors.white))),
              body: SafeArea(
                  child: Query(
                options: QueryOptions(
                  documentNode: gql(GRAPHQL_GET_MY_ASSIGNMENTS_QUERY),
                ),
                // Just like in apollo refetch() could be used to manually trigger a refetch
                // while fetchMore() can be used for pagination purpose
                builder: (QueryResult result,
                    {VoidCallback refetch, FetchMore fetchMore}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }

                  if (result.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  print(result);
                  return Text('sadsa');
                  // it can be either Map or List
                  // List repositories =
                  //     result.data['viewer']['repositories']['nodes'];

                  // return ListView.builder(
                  //     itemCount: repositories.length,
                  //     itemBuilder: (context, index) {
                  //       final repository = repositories[index];

                  //       return Text(repository['name']);
                  //     });
                },
              )),
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
