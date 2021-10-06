import 'package:acudia/app_localizations.dart';
import 'package:acudia/colors.dart';
import 'package:acudia/components/cards/acudier_card.dart';
import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:acudia/core/entity/comment_entity.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/entity/profile_entity.dart';
import 'package:acudia/core/providers/assignment_provider.dart';
import 'package:acudia/core/services/assignments/assignments_service.dart';
import 'package:acudia/routes.dart';
import 'package:acudia/ui/screens/main/acudier/acudier_details_args.dart';
import 'package:acudia/ui/screens/main/hospital/details/hospital_details_args.dart';
import 'package:acudia/ui/screens/main/hospital/details/hospital_details_filters_panel.dart';
import 'package:acudia/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:sliding_up_panel/sliding_up_panel.dart';

class HospitalDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HospitalArguments args = ModalRoute.of(context).settings.arguments;
    final Hospital hospitalData = args.hospital;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    Provider.of<AssignmentsProvider>(context, listen: false).resetFilterValues();

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  SliverOverlapAbsorber(
                    sliver: SliverSafeArea(
                        top: false,
                        sliver: SliverAppBar(
                          brightness: Brightness.dark,
                          collapsedHeight: 52,
                          toolbarHeight: 50,
                          expandedHeight: 180.0,
                          floating: false,
                          pinned: true,
                          centerTitle: true,
                          flexibleSpace: FlexibleSpaceBar(
                            title: LayoutBuilder(builder: (context, size) {
                              var span = TextSpan(
                                  text: hospitalData.name,
                                  style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor));

                              return Container(
                                margin: EdgeInsets.only(
                                    left: size.maxHeight > 180 ? 16 : 48, right: size.maxHeight > 180 ? 16 : 48),
                                child: Text.rich(
                                  span,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: size.maxHeight > 180 ? 3 : 1,
                                ),
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
                        panelBuilder: (sc) => FilterPanel(scrollController: sc),
                        minHeight: 100,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
                        body: Consumer<AssignmentsProvider>(
                            builder: (context, assignmentsProvider, child) => SingleChildScrollView(
                                  child: Query(
                                      options:
                                          QueryOptions(documentNode: gql(GRAPHQL_SEARCH_ASSIGNMENTS_QUERY), variables: {
                                        "hospId": hospitalData.codCNH,
                                        "from": assignmentsProvider.assignment.from != null
                                            ? dateFormat.format(assignmentsProvider.assignment.from)
                                            : null,
                                        "to": assignmentsProvider.assignment.to != null
                                            ? dateFormat.format(assignmentsProvider.assignment.to)
                                            : null,
                                        "startHour": assignmentsProvider.assignment.startHour != null
                                            ? assignmentsProvider.assignment.startHour.hour * 3600 +
                                                assignmentsProvider.assignment.startHour.minute * 60
                                            : null,
                                        "endHour": assignmentsProvider.assignment.endHour != null
                                            ? assignmentsProvider.assignment.endHour.hour * 3600 +
                                                assignmentsProvider.assignment.endHour.minute * 60
                                            : null,
                                        "minFare": assignmentsProvider.rangeValues.start,
                                        "maxFare": assignmentsProvider.rangeValues.end,
                                      }),
                                      builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
                                        if (result.hasException) {
                                          return Text(result.exception.toString());
                                        }

                                        if (result.loading) {
                                          return Container(
                                              width: 50,
                                              height: 50,
                                              margin: EdgeInsets.only(top: 80, left: 40, right: 40),
                                              child: Center(child: CircularProgressIndicator()));
                                        }

                                        List<Widget> widgetList = [];
                                        List<dynamic> responseList = result.data["searchAssignments"]["items"];

                                        if (responseList != null && responseList.length > 0) {
                                          widgetList.add(Container(
                                              margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
                                              padding: EdgeInsets.all(12),
                                              child: Text(
                                                  translate(context, 'assignment_search_displaying_num_results')
                                                      .replaceFirst('{{ num }}', responseList.length.toString()),
                                                  style: TextStyle(color: Theme.of(context).highlightColor))));
                                          responseList.forEach((dynamic responseJson) {
                                            Profile acudier = Profile.fromJson(responseJson["acudier"]['profile']);
                                            List<Comment> comments =
                                                Comment.fromJsonList(responseJson['acudier']['comments']);
                                            List<Assignment> assignments =
                                                Assignment.fromJsonList(responseJson["assignment"]);

                                            widgetList.add(AcudierCard(
                                                name: acudier.name,
                                                secondName: acudier.secondName,
                                                photoUrl: acudier.photoUrl,
                                                age: calculateAge(acudier.birthDate),
                                                numJobs: acudier.jobsCompleted,
                                                popularity: acudier.popularity,
                                                onPress: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    Routes.ACUDIER_DETAILS,
                                                    arguments: AcudierDetailsArguments(
                                                        acudier: acudier,
                                                        comments: comments,
                                                        hospital: hospitalData,
                                                        assignments: assignments),
                                                  );
                                                }));
                                          });
                                          return Column(children: widgetList);
                                        } else {
                                          return Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).highlightColor,
                                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 8,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
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
                                                    child: Text(translate(context, 'no_acudiers_available'),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Theme.of(context).scaffoldBackgroundColor)))
                                              ])));
                                        }
                                      }),
                                )),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 24, left: 20, right: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(Icons.location_city),
                                SizedBox(width: 8),
                                Flexible(
                                    child: Text(
                                  hospitalData.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ))
                              ]),
                              SizedBox(height: 16),
                              Row(children: [
                                Icon(Icons.add_location_rounded),
                                SizedBox(width: 8),
                                Flexible(
                                    child: Text(
                                  '${hospitalData.address} - ${hospitalData.postalCode}, ${hospitalData.province}',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ))
                              ]),
                              SizedBox(height: 32),
                              Text(
                                'Información general',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Divider(height: 4, thickness: 2, color: aCTextColor),
                              SizedBox(height: 16),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Especialidad'),
                                    SizedBox(width: 8),
                                    Flexible(
                                        child: Text(
                                      hospitalData.healthCarePurpose,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ))
                                  ]),
                              SizedBox(height: 16),
                              Divider(height: 4, thickness: 1),
                              SizedBox(height: 16),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Tipo'),
                                    SizedBox(width: 8),
                                    Flexible(
                                        child: Text(
                                      hospitalData.patrimonialDependence,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ))
                                  ]),
                              SizedBox(height: 16),
                              Divider(height: 4, thickness: 1),
                              SizedBox(height: 16),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('C.A'),
                                    SizedBox(width: 8),
                                    Flexible(
                                        child: Text(
                                      hospitalData.state,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ))
                                  ]),
                              SizedBox(height: 16),
                              Divider(height: 4, thickness: 1),
                              SizedBox(height: 16),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Contacto'),
                                    SizedBox(width: 8),
                                    Flexible(
                                        child: Text(
                                      '+34 ${hospitalData.phone}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ))
                                  ]),
                              SizedBox(height: 16),
                              Divider(height: 4, thickness: 1),
                              SizedBox(height: 32),
                              Text(
                                'Ubicación',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Divider(height: 4, thickness: 2, color: aCTextColor),
                              SizedBox(height: 16),
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: GoogleMap(
                                  mapToolbarEnabled: false,
                                  rotateGesturesEnabled: false,
                                  zoomControlsEnabled: false,
                                  zoomGesturesEnabled: false,
                                  compassEnabled: false,
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(hospitalData.coords['lat'], hospitalData.coords['lng']), zoom: 18),
                                ),
                              )
                            ]),
                      )
                    ],
                  )))),
        ));
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
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}

class CustomScrollConfig extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
