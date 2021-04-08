import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/entity/profile_entity.dart';
import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/ui/screens/main/acudier/acudier_details_args.dart';
import 'package:acudia/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

const HEADER_HEIGHT = 340.0;
const BOTTOM_BOX_HEIGHT = 120.0;

class AcudierDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AcudierDetailsArguments args = ModalRoute.of(context).settings.arguments;
    final Profile acudier = args.acudier;

    DateFormat dateFormat = new DateFormat.yMMMM('es');

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
                                expandedHeight: HEADER_HEIGHT,
                                floating: false,
                                pinned: true,
                                centerTitle: true,
                                flexibleSpace: FlexibleSpaceBar(
                                    centerTitle: true,
                                    title: LayoutBuilder(builder: (context, size) {
                                      if (size.maxHeight <= 80)
                                        return Text('${acudier.name} ${acudier.secondName}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                            ));
                                      return Container();
                                    }),
                                    background: Image.network(
                                      acudier.photoUrl,
                                      fit: BoxFit.cover,
                                    )),
                              )),
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        ),
                      ];
                    },
                    body: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                          Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 32, left: 20, right: 20, bottom: 32),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text('${acudier.name} ${acudier.secondName}',
                                                    style: TextStyle(
                                                      fontSize: 24.0,
                                                      fontWeight: FontWeight.w500,
                                                    ))),
                                            Container(
                                                child: Text(
                                                    translate(context, 'computed_age').replaceAll(
                                                        '{{ age }}', calculateAge(acudier.birthDate).toString()),
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                    ))),
                                            SizedBox(height: 20),
                                            Divider(height: 4, thickness: 1),
                                            SizedBox(height: 20),
                                            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                              Icon(Icons.calendar_today_outlined),
                                              SizedBox(width: 8),
                                              Text(translate(context, 'member_since').replaceAll('{{ date }}',
                                                  '${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(acudier.createdAt))}'))
                                            ]),
                                            SizedBox(height: 20),
                                            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                              Icon(Icons.work_outline),
                                              SizedBox(width: 8),
                                              Text(translate(context, 'jobs_completed')
                                                  .replaceAll('{{ jobs }}', '${acudier.jobsCompleted}'))
                                            ]),
                                            SizedBox(height: 20),
                                            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                              Icon(Icons.star_border_outlined),
                                              SizedBox(width: 8),
                                              Text(translate(context, "popularity_${acudier.popularity.round()}")),
                                              SizedBox(width: 4),
                                              Text('('),
                                              Text(translate(context, "popularity_number")
                                                  .replaceAll("{{ num }}", '${acudier.popularity}')),
                                              Text(')')
                                            ])
                                          ],
                                        )))),
                          ),
                          Container(
                            color: Colors.black,
                            width: MediaQuery.of(context).size.width,
                            height: BOTTOM_BOX_HEIGHT,
                            child: Text('sadsa'),
                          ),
                        ]))))));
  }
}
