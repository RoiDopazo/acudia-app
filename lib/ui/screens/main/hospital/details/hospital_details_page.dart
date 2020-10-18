import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/ui/screens/main/hospital/details/hospital_details_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class HospitalDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HospitalArguments args = ModalRoute.of(context).settings.arguments;

    print(args.hospital.name.length);
    print(MediaQuery.of(context).size.width);

    return Consumer<HospitalProvider>(
        builder: (context, hospProvider, child) => DefaultTabController(
            length: 2,
            child: Scaffold(
              body: NestedScrollView(
                  headerSliverBuilder: (context, value) {
                    return [
                      SliverAppBar(
                        collapsedHeight: 52,
                        toolbarHeight: 50,
                        expandedHeight: 240.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          title: LayoutBuilder(builder: (context, size) {
                            var span = TextSpan(
                                text: args.hospital.name,
                                style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor));

                            return Text.rich(
                              span,
                              overflow: TextOverflow.ellipsis,
                              maxLines: size.maxHeight > 180 ? 3 : 1,
                            );
                          }),
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverAppBarDelegate(
                          minHeight: 60.0,
                          maxHeight: 60.0,
                          child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: TabBar(
                                    tabs: [
                                      Tab(child: Text('Búsqueda')),
                                      Tab(child: Text('Detalles')),
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
                          SingleChildScrollView(
                              child: Column(children: [
                            Text('3213123'),
                            SizedBox(height: 400),
                            Text('3213123'),
                            SizedBox(height: 400),
                            Text('3213123'),
                            SizedBox(height: 400)
                          ])),
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
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}

class CustomScrollConfig extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
