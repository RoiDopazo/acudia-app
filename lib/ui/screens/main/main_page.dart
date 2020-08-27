import 'package:acudia/core/providers/app_provider.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/ui/screens/main/profile/profile_page.dart';
import 'package:acudia/ui/screens/main/search/hospital_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatelessWidget {
  static List<Widget> _widgetOptions = <Widget>[
    HospitalSearchPage(),
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
            : Scaffold(
                body: Center(
                  child: _widgetOptions.elementAt(app.selectedTab),
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
                          color: Colors.white,
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
                                color: Colors.white),
                        title: Text(''),
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          app.selectedTab == 2
                              ? 'assets/media/icon_user_profile.svg'
                              : 'assets/media/icon_user_profile_outlined.svg',
                          height: 24,
                          color: Colors.white,
                        ),
                        title: Text(''),
                      ),
                    ],
                    currentIndex: app.selectedTab,
                    backgroundColor: Theme.of(context).primaryColor,
                    selectedItemColor: Theme.of(context).backgroundColor,
                    onTap: (index) {
                      Provider.of<AppProvider>(context, listen: false)
                          .setSelectedTab(context, index);
                    })));
  }
}
