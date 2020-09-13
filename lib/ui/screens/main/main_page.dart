import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/providers/app_provider.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/ui/screens/main/hospital/assignments/hospital_assignments_page.dart';
import 'package:acudia/ui/screens/main/hospital/search/hospital_search_page.dart';
import 'package:acudia/ui/screens/main/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatelessWidget {
  static List<Widget> _clientWidgetOptions = <Widget>[
    HospitalSearchPage(),
    Text(
      'Under development',
    ),
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
                    bottomNavigationBar: BottomNavigationBar(
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              app.selectedTab == 0
                                  ? 'assets/media/icon_home.svg'
                                  : 'assets/media/icon_home_outlined.svg',
                              height: 24,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(''),
                          ),
                          BottomNavigationBarItem(
                            icon: app.selectedTab == 1
                                ? Image(
                                    image: AssetImage(
                                        'assets/media/icon_agreement.png'),
                                    height: 32,
                                  )
                                : SvgPicture.asset(
                                    'assets/media/icon_agreement_outlined.svg',
                                    height: 32,
                                    color: Theme.of(context).primaryColor),
                            title: Text(''),
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              app.selectedTab == 2
                                  ? 'assets/media/icon_user_profile.svg'
                                  : 'assets/media/icon_user_profile_outlined.svg',
                              height: 24,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(''),
                          ),
                        ],
                        currentIndex: app.selectedTab,
                        backgroundColor: Theme.of(context).backgroundColor,
                        selectedItemColor: Theme.of(context).primaryColor,
                        onTap: (index) {
                          Provider.of<AppProvider>(context, listen: false)
                              .setSelectedTab(context, index);
                        }))
                : Scaffold(
                    body: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              Text(
                                  translate(context, 'error_unexpected_label')),
                              FlatButton(
                                onPressed: () =>
                                    Provider.of<ProfileProvider>(context)
                                        .getProfileData(context, null),
                                child: Text(translate(context, 'refresh')),
                              )
                            ])))));
  }
}
