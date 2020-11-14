import 'package:acudia/app_localizations.dart';
import 'package:acudia/components/cards/acudier_card.dart';
import 'package:acudia/core/entity/profile_entity.dart';
import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/core/services/assignments/assignments_service.dart';
import 'package:acudia/ui/screens/main/hospital/details/hospital_details_args.dart';
import 'package:acudia/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:sliding_up_panel/sliding_up_panel.dart';

class HospitalDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HospitalArguments args = ModalRoute.of(context).settings.arguments;

    return Consumer<HospitalProvider>(
        builder: (context, hospProvider, child) => DefaultTabController(
            length: 2,
            child: Scaffold(
              body: NestedScrollView(
                  headerSliverBuilder: (context, value) {
                    return [
                      SliverOverlapAbsorber(
                        sliver: SliverSafeArea(
                            top: false,
                            sliver: SliverAppBar(
                              collapsedHeight: 52,
                              toolbarHeight: 50,
                              expandedHeight: 240.0,
                              floating: false,
                              pinned: true,
                              flexibleSpace: FlexibleSpaceBar(
                                title: LayoutBuilder(builder: (context, size) {
                                  var span = TextSpan(
                                      text: args.hospital.name,
                                      style: TextStyle(
                                          color: Theme.of(context).scaffoldBackgroundColor));

                                  return Text.rich(
                                    span,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: size.maxHeight > 180 ? 3 : 1,
                                  );
                                }),
                              ),
                            )),
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverAppBarDelegate(
                          minHeight: 58.0,
                          maxHeight: 58.0,
                          child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: TabBar(
                                    tabs: [
                                      Tab(child: Text(translate(context, 'search'))),
                                      Tab(child: Text(translate(context, 'details'))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ];
                  },
                  body: ScrollConfiguration(
                      behavior: CustomScrollConfig(),
                      child: Container(
                          child: TabBarView(
                        children: [
                          SlidingUpPanel(
                            panelBuilder: (sc) => _panel(sc, context),
                            minHeight: 80,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
                            body: SingleChildScrollView(
                              child: Query(
                                  options: QueryOptions(
                                      documentNode: gql(GRAPHQL_SEARCH_ASSIGNMENTS_QUERY),
                                      variables: {"hospId": args.hospital.codCNH}),
                                  builder: (QueryResult result,
                                      {VoidCallback refetch, FetchMore fetchMore}) {
                                    if (result.hasException) {
                                      return Text(result.exception.toString());
                                    }

                                    if (result.loading) {
                                      return LinearProgressIndicator();
                                    }

                                    List<Widget> wigetList = [];
                                    List<dynamic> responseList =
                                        result.data["searchAssignments"]["items"];

                                    if (responseList != null && responseList.length > 0) {
                                      responseList.forEach((dynamic responseJson) {
                                        Profile acudier = Profile.fromJson(responseJson["acudier"]);
                                        wigetList.add(AcudierCard(
                                          name: acudier.name,
                                          secondName: acudier.secondName,
                                          photoUrl: acudier.photoUrl,
                                          age: calculateAge(acudier.birthDate),
                                          numJobs:
                                              math.Random.secure().nextInt(30), //FIXME: not random
                                          popularity: math.Random.secure().nextDouble() *
                                              5, //FIXME: not random
                                        ));
                                      });
                                      return Column(children: wigetList);
                                    } else {
                                      return Container(
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).highlightColor,
                                              borderRadius:
                                                  BorderRadius.all(Radius.circular(12.0))),
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(top: 80, left: 40, right: 40),
                                          child: Center(
                                              child: Row(children: [
                                            Icon(
                                              Icons.info_outline,
                                              size: 24.0,
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                            ),
                                            SizedBox(width: 8),
                                            Flexible(
                                                child: Text(
                                                    translate(context, 'no_acudiers_available'),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor)))
                                          ])));
                                    }
                                  }),
                            ),
                          ),
                          Container(child: Icon(Icons.directions_transit)),
                        ],
                      )))),
            )));
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CustomScrollConfig extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

Widget _panel(ScrollController sc, context) {
  return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300], borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ],
          ),
          SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                translate(context, "filters"),
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 36.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[],
          ),
          SizedBox(
            height: 36.0,
          ),
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Images",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 36.0,
          ),
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("About",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  """Pittsburgh is a city in the state of Pennsylvania in the United States, and is the county seat of Allegheny County. A population of about 302,407 (2018) residents live within the city limits, making it the 66th-largest city in the U.S. The metropolitan population of 2,324,743 is the largest in both the Ohio Valley and Appalachia, the second-largest in Pennsylvania (behind Philadelphia), and the 27th-largest in the U.S.\n\nPittsburgh is located in the southwest of the state, at the confluence of the Allegheny, Monongahela, and Ohio rivers. Pittsburgh is known both as "the Steel City" for its more than 300 steel-related businesses and as the "City of Bridges" for its 446 bridges. The city features 30 skyscrapers, two inclined railways, a pre-revolutionary fortification and the Point State Park at the confluence of the rivers. The city developed as a vital link of the Atlantic coast and Midwest, as the mineral-rich Allegheny Mountains made the area coveted by the French and British empires, Virginians, Whiskey Rebels, and Civil War raiders.\n\nAside from steel, Pittsburgh has led in manufacturing of aluminum, glass, shipbuilding, petroleum, foods, sports, transportation, computing, autos, and electronics. For part of the 20th century, Pittsburgh was behind only New York City and Chicago in corporate headquarters employment; it had the most U.S. stockholders per capita. Deindustrialization in the 1970s and 80s laid off area blue-collar workers as steel and other heavy industries declined, and thousands of downtown white-collar workers also lost jobs when several Pittsburgh-based companies moved out. The population dropped from a peak of 675,000 in 1950 to 370,000 in 1990. However, this rich industrial history left the area with renowned museums, medical centers, parks, research centers, and a diverse cultural district.\n\nAfter the deindustrialization of the mid-20th century, Pittsburgh has transformed into a hub for the health care, education, and technology industries. Pittsburgh is a leader in the health care sector as the home to large medical providers such as University of Pittsburgh Medical Center (UPMC). The area is home to 68 colleges and universities, including research and development leaders Carnegie Mellon University and the University of Pittsburgh. Google, Apple Inc., Bosch, Facebook, Uber, Nokia, Autodesk, Amazon, Microsoft and IBM are among 1,600 technology firms generating \$20.7 billion in annual Pittsburgh payrolls. The area has served as the long-time federal agency headquarters for cyber defense, software engineering, robotics, energy research and the nuclear navy. The nation's eighth-largest bank, eight Fortune 500 companies, and six of the top 300 U.S. law firms make their global headquarters in the area, while RAND Corporation (RAND), BNY Mellon, Nova, FedEx, Bayer, and the National Institute for Occupational Safety and Health (NIOSH) have regional bases that helped Pittsburgh become the sixth-best area for U.S. job growth.
                  """,
                  softWrap: true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ));
}
