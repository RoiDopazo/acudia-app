import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/core/services/requests/request_service.dart';
import 'package:acudia/ui/screens/main/request/completed_request_tab.dart';
import 'package:acudia/ui/screens/main/request/incoming_request_tab.dart';
import 'package:acudia/ui/screens/main/request/inprogres_request_tab.dart';
import 'package:acudia/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class ClientRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    USER_ROLES role = Provider.of<ProfileProvider>(context).profile.role;
    bool isClient = role.toString().split('.')[1] == USER_ROLES.CLIENT.toString().split('.')[1];
    List<String> statusList = [
      REQUEST_STATUS.PENDING.toString().split('.')[1],
      REQUEST_STATUS.ACCEPTED.toString().split('.')[1]
    ];
    if (isClient) statusList.add(REQUEST_STATUS.REJECTED.toString().split('.')[1]);

    return DefaultTabController(
        length: 3,
        child: Query(
            options: QueryOptions(
                documentNode: gql(GRAPHQL_GET_MY_REQUESTS),
                variables: {"role": role.toString().split('.')[1], "status": statusList.join(',')}),
            builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Scaffold(
                  appBar: AppBar(
                      brightness: Brightness.dark,
                      title: Text(
                        translate(context, "requests"),
                        style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                      bottom: TabBar(
                        tabs: [
                          Tab(
                              child: Text(
                            translate(context, 'incoming_request'),
                            style: TextStyle(fontSize: 14, color: Theme.of(context).scaffoldBackgroundColor),
                          )),
                          Tab(
                            child: Text(
                              translate(context, 'inprogress_request'),
                              style: TextStyle(fontSize: 14, color: Theme.of(context).scaffoldBackgroundColor),
                            ),
                          ),
                          Tab(
                              child: Text(translate(context, 'completed_requests'),
                                  style: TextStyle(fontSize: 14, color: Theme.of(context).scaffoldBackgroundColor))),
                        ],
                      )),
                  body: TabBarView(children: [
                    IncomingRequestTab(requests: result.data["getMyRequests"]["incoming"]),
                    InProgressRequestTab(requests: result.data["getMyRequests"]["active"]),
                    CompletedRequestTab()
                  ]));
            }));
  }
}
