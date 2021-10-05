import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/providers/app_provider.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/ui/screens/main/hospital/assignments/hospital_assignments_page.dart';
import 'package:acudia/ui/screens/main/hospital/search/hospital_search_page.dart';
import 'package:acudia/ui/screens/main/profile/profile_page.dart';
import 'package:acudia/ui/screens/main/request/client_request_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  static List<Widget> _clientWidgetOptions = <Widget>[
    HospitalSearchPage(),
    ClientRequestPage(),
    ProfilePage(),
  ];

  static List<Widget> _acudierWidgetOptions = <Widget>[
    HospitalAssignmentsPage(),
    Text(
      'Under development',
    ),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppProvider, ProfileProvider>(
        builder: (context, app, profile, child) => profile.loading
            ? Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
            : profile.profile != null
                ? Scaffold(
                    body: Center(
                      child: profile.profile.isAcudier
                          ? _acudierWidgetOptions.elementAt(app.selectedTab)
                          : _clientWidgetOptions.elementAt(app.selectedTab),
                    ),
                    bottomNavigationBar: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: BottomNavigationBar(
                          showSelectedLabels: true,
                          showUnselectedLabels: true,
                          elevation: 8,
                          items: <BottomNavigationBarItem>[
                            profile.profile.isAcudier
                                ? BottomNavigationBarItem(
                                    icon: Icon(Icons.mail_outline),
                                    label: translate(context, "assignments"),
                                  )
                                : BottomNavigationBarItem(
                                    icon: Icon(Icons.search),
                                    label: translate(context, "search"),
                                  ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.compare_arrows),
                              label: translate(context, "requests"),
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.face),
                              label: translate(context, "auth_step2"),
                            ),
                          ],
                          currentIndex: app.selectedTab,
                          backgroundColor: Theme.of(context).backgroundColor,
                          selectedItemColor: Theme.of(context).primaryColor,
                          onTap: (index) {
                            Provider.of<AppProvider>(context, listen: false).setSelectedTab(context, index);
                          }),
                    ))
                : Scaffold(
                    body: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              Text(translate(context, 'error_unexpected_label')),
                              FlatButton(
                                onPressed: () => Provider.of<ProfileProvider>(context).getProfileData(context, null),
                                child: Text(translate(context, 'refresh')),
                              )
                            ])))));
  }
}
