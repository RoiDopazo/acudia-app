import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/aws/cognito_service.dart';
import 'package:acudia/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

var aaa = """query listClients {
    listClients {
        items {
            name
        }
    }
}""";

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logoutButton = new ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 50.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side:
                BorderSide(color: Theme.of(context).textTheme.bodyText1.color)),
        padding: const EdgeInsets.all(16.0),
        textColor: Theme.of(context).textTheme.bodyText1.color,
        color: Theme.of(context).backgroundColor,
        onPressed: () {
          CognitoService.logout();
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.SPLASH, (Route<dynamic> route) => false);
        },
        child: new Text(translate(context, 'auth_logout')),
      ),
    );

    return Container(child: logoutButton);

    // return Query(
    //     options: QueryOptions(
    //       documentNode: gql(aaa), // this is the query string you just created
    //       variables: {
    //         'nRepositories': 50,
    //       },
    //       // pollInterval: 10,
    //     ),
    //     // Just like in apollo refetch() could be used to manually trigger a refetch
    //     // while fetchMore() can be used for pagination purpose
    //     builder: (QueryResult result,
    //         {VoidCallback refetch, FetchMore fetchMore}) {
    //       if (result.hasException) {
    //         return Text(result.exception.toString());
    //       }

    //       if (result.loading) {
    //         return Text('Loading');
    //       }

    //       // it can be either Map or List
    //       List repositories = result.data['listClients']['items'];
    //       return ListView.builder(
    //           itemCount: repositories.length,
    //           itemBuilder: (context, index) {
    //             final repository = repositories[index];

    //             return Text(repository['name']);
    //           });
    //     });
  }
}
