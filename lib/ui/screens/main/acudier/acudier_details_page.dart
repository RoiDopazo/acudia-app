import 'package:acudia/app_localizations.dart';
import 'package:acudia/components/reviews/review-list.dart';
import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:acudia/core/entity/comment_entity.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/entity/profile_entity.dart';
import 'package:acudia/core/providers/availability_provider.dart';
import 'package:acudia/routes.dart';
import 'package:acudia/ui/screens/main/acudier/acudier_details_args.dart';
import 'package:acudia/ui/screens/main/acudier/availability/acudier_availability_args.dart';
import 'package:acudia/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

const HEADER_HEIGHT = 340.0;
const BOTTOM_BOX_HEIGHT = 80.0;

class AcudierDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AcudierDetailsArguments args = ModalRoute.of(context).settings.arguments;
    final Profile acudier = args.acudier;
    final Hospital hospital = args.hospital;
    final List<Assignment> assignments = args.assignments;
    final List<Comment> comments = args.comments;

    DateFormat dateFormat = new DateFormat.yMMMM('es');

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
                                        SizedBox(height: 24),
                                        Divider(height: 4, thickness: 1),
                                        SizedBox(height: 24),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                          Container(
                                              width: MediaQuery.of(context).size.width - 88,
                                              child: Text(hospital.name,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w500,
                                                  ))),
                                          SvgPicture.asset('assets/media/icon_hospital.svg', height: 48),
                                        ]),
                                        Wrap(
                                          children: [
                                            Text(hospital.healthCarePurpose),
                                            Text(' · '),
                                            Text(hospital.province),
                                            Text(' · '),
                                            Text(hospital.state)
                                          ],
                                        ),
                                        SizedBox(height: 24),
                                        Divider(height: 4, thickness: 1),
                                        SizedBox(height: 24),
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
                                        ]),
                                        SizedBox(height: 24),
                                        Divider(height: 4, thickness: 1),
                                        SizedBox(height: 24),
                                        comments.length > 0
                                            ? Container(
                                                child: Text(translate(context, 'latest_reviews'),
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.w500,
                                                    )))
                                            : Container(),
                                        SizedBox(height: 24),
                                        ReviewList(comments: comments)
                                      ],
                                    )))),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: BOTTOM_BOX_HEIGHT,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3)),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${assignments[0].fare.toStringAsFixed(2)} €/h',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                    padding: const EdgeInsets.all(16.0),
                                    textColor: Theme.of(context).backgroundColor,
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      Provider.of<AvailabilityProvider>(context, listen: false)
                                          .setRangeHours(assignments[0].startHour, assignments[0].endHour, null, null);
                                      Provider.of<AvailabilityProvider>(context, listen: false).reset();
                                      Navigator.pushNamed(
                                        context,
                                        Routes.ACUDIER_AVAILABILITY,
                                        arguments: AcudierAvailabilityArguments(
                                            acudier: acudier,
                                            comments: comments,
                                            hospital: hospital,
                                            assignments: assignments),
                                      );
                                    },
                                    child: new Text(translate(context, 'check_availability')),
                                  ))
                            ],
                          ),
                        ),
                      )
                    ])))));
  }
}
