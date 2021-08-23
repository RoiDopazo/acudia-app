import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/entity/profile_entity.dart';
import 'package:acudia/core/entity/request_entity.dart';
import 'package:acudia/core/providers/availability_provider.dart';
import 'package:acudia/core/services/acudiers/acudiers_service.dart';
import 'package:acudia/routes.dart';
import 'package:acudia/ui/screens/main/acudier/availability/acudier_availability_args.dart';
import 'package:acudia/ui/screens/main/acudier/confirm/acudier_confirm_args.dart';
import 'package:acudia/utils/constants.dart';
import 'package:acudia/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vertical_calendar/vertical_calendar.dart';
import 'package:badges/badges.dart';

class AcudierAvailabiltyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AcudierAvailabilityArguments args = ModalRoute.of(context).settings.arguments;
    final Profile acudier = args.acudier;
    final Hospital hospital = args.hospital;
    final List<Assignment> assignments = args.assignments;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: BackButton(color: Theme.of(context).accentColor),
          elevation: 0,
        ),
        body: Query(
            options: QueryOptions(documentNode: gql(GRAPHQL_GET_ACUDIER_REQUESTS), variables: {
              "acudier": acudier.PK.substring(acudier.PK.indexOf('#') + 1),
              "status": REQUEST_STATUS.ACCEPTED.toString().split('.')[1]
            }),
            builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<Request> requests = Request.fromJsonList(result.data['getAcudierRequests']['items']);

              return Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Column(children: [
                    Text('${acudier.name} ${acudier.secondName}',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                        )),
                    Text(hospital.name,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14.0,
                        ))
                  ]),
                ),
                Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Consumer<AvailabilityProvider>(
                        builder: (context, availability, child) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlatButton(
                                    onPressed: () {
                                      showMaterialTimePicker(
                                          context: context,
                                          selectedTime: availability.startHour,
                                          onChanged: (value) =>
                                              Provider.of<AvailabilityProvider>(context, listen: false)
                                                  .setRangeHours(value, availability.endHour, assignments, requests));
                                    },
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Theme.of(context).accentColor, width: 1, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(50)),
                                    child: Text(
                                      '${normalizeTime(availability.startHour.hour)}:${normalizeTime(availability.startHour.minute)}',
                                      style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor),
                                    )),
                                SizedBox(width: 20),
                                Text(translate(context, 'to')),
                                SizedBox(width: 20),
                                FlatButton(
                                    onPressed: () {
                                      showMaterialTimePicker(
                                          context: context,
                                          selectedTime: availability.endHour,
                                          onChanged: (value) =>
                                              Provider.of<AvailabilityProvider>(context, listen: false)
                                                  .setRangeHours(availability.startHour, value, assignments, requests));
                                    },
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Theme.of(context).accentColor, width: 1, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(50)),
                                    child: Text(
                                      '${normalizeTime(availability.endHour.hour)}:${normalizeTime(availability.endHour.minute)}',
                                      style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor),
                                    )),
                              ],
                            ))),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.only(top: 24, left: 0, right: 0, bottom: 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${translate(context, 'mon')}.',
                            style: TextStyle(fontSize: 12, color: Theme.of(context).accentColor)),
                        Text('${translate(context, 'tue')}.',
                            style: TextStyle(fontSize: 12, color: Theme.of(context).accentColor)),
                        Text('${translate(context, 'wed')}.',
                            style: TextStyle(fontSize: 12, color: Theme.of(context).accentColor)),
                        Text('${translate(context, 'thu')}.',
                            style: TextStyle(fontSize: 12, color: Theme.of(context).accentColor)),
                        Text('${translate(context, 'fri')}.',
                            style: TextStyle(fontSize: 12, color: Theme.of(context).accentColor)),
                        Text('${translate(context, 'sat')}.',
                            style: TextStyle(fontSize: 12, color: Theme.of(context).accentColor)),
                        Text('${translate(context, 'sun')}.',
                            style: TextStyle(fontSize: 12, color: Theme.of(context).accentColor)),
                      ]),
                ),
                Divider(height: 4, thickness: 1),
                Expanded(
                    child: Consumer<AvailabilityProvider>(
                        builder: (context, availability, child) => VerticalCalendar(
                              minDate: DateTime.now(),
                              maxDate: DateTime.now().add(Duration(days: (365 / 2).ceil())),
                              onRangeSelected: (DateTime d1, DateTime d2) {
                                Provider.of<AvailabilityProvider>(context, listen: false)
                                    .setSelectedDates(d1, d2, assignments, requests);
                              },
                              monthBuilder: (BuildContext context, int month, int year) {
                                return Container(
                                    margin: EdgeInsets.only(top: 32, left: 20, bottom: 12),
                                    alignment: Alignment.centerLeft,
                                    child: Text(capitalize(DateFormat('MMMM yyyy').format(DateTime(year, month))),
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)));
                              },
                              dayBuilder: (BuildContext context, DateTime date, {bool isSelected}) {
                                int result = isDayAvailable(
                                    date, assignments, requests, availability.startHour, availability.endHour);
                                bool isAvailable = result == 2;
                                bool isPartialAvailable = result == 1;
                                bool isDateSelected = false;
                                if (availability.endDate != null) {
                                  isDateSelected = isSelected &&
                                      (date.isAfter(availability.startDate) ||
                                          date.isAtSameMomentAs(availability.startDate)) &&
                                      (date.isBefore(availability.endDate) ||
                                          date.isAtSameMomentAs(availability.endDate));
                                } else {
                                  isDateSelected = isSelected && date.isAtSameMomentAs(availability.startDate);
                                }

                                if (isDateSelected) {
                                  return Ink(
                                    decoration: BoxDecoration(
                                        color: isAvailable
                                            ? Theme.of(context).accentColor
                                            : Theme.of(context).backgroundColor,
                                        shape: BoxShape.rectangle),
                                    child: Badge(
                                        position: BadgePosition.bottomEnd(bottom: 14, end: 14),
                                        padding: EdgeInsets.all(isPartialAvailable && !isAvailable ? 2 : 0),
                                        badgeColor: Theme.of(context).highlightColor,
                                        child: Center(
                                          child: Text(
                                            date.day.toString(),
                                            style: TextStyle(
                                                decoration:
                                                    isAvailable ? TextDecoration.none : TextDecoration.lineThrough,
                                                color: isAvailable
                                                    ? Theme.of(context).scaffoldBackgroundColor
                                                    : Theme.of(context).accentColor),
                                          ),
                                        )),
                                  );
                                }

                                return Ink(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor, shape: BoxShape.circle),
                                  child: Badge(
                                      position: BadgePosition.bottomEnd(bottom: 14, end: 14),
                                      padding: EdgeInsets.all(isPartialAvailable && !isAvailable ? 2 : 0),
                                      badgeColor: Theme.of(context).highlightColor,
                                      child: Center(
                                        child: Text(
                                          date.day.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  isAvailable ? TextDecoration.none : TextDecoration.lineThrough,
                                              color: isAvailable
                                                  ? Theme.of(context).accentColor
                                                  : Theme.of(context).accentColor.withOpacity(0.3)),
                                        ),
                                      )),
                                );
                              },
                            ))),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: BOTTOM_BOX_HEIGHT,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.6), spreadRadius: 5, blurRadius: 7, offset: Offset(0, 3)),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Consumer<AvailabilityProvider>(
                          builder: (context, availability, child) => Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: availability.price == null
                                          ? ((availability.startDate == null && availability.endDate == null
                                              ? Text(translate(context, 'select_dates'))
                                              : Builder(builder: (context) {
                                                  Assignment selectedAssignment = assignments.firstWhere(
                                                      (assig) =>
                                                          (availability.startDate.isBefore(assig.to) &&
                                                              availability.startDate.isAfter(assig.from)) &&
                                                          ((availability.endDate.isBefore(assig.to)) &&
                                                              (availability.endDate.isAfter(assig.from))),
                                                      orElse: () => null);

                                                  Request selectedRequest = requests.firstWhere(
                                                      (assig) =>
                                                          (availability.startDate.isAtSameMomentAs(assig.from) ||
                                                              availability.startDate.isBefore(assig.to) &&
                                                                  availability.startDate.isAtSameMomentAs(assig.to) ||
                                                              availability.startDate.isAfter(assig.from)) ||
                                                          ((availability.endDate.isAtSameMomentAs(assig.to) ||
                                                                  availability.endDate.isBefore(assig.to)) &&
                                                              (availability.endDate.isAtSameMomentAs(assig.from) ||
                                                                  availability.endDate.isAfter(assig.from))),
                                                      orElse: () => null);

                                                  if (selectedAssignment == null || selectedRequest != null) {
                                                    return Text(translate(context, 'no_available'));
                                                  }

                                                  return Text(
                                                      translate(context, 'no_available_in_dates')
                                                          .replaceFirst('{{ startHour }}',
                                                              '${normalizeTime(selectedAssignment.startHour.hour)}:${normalizeTime(selectedAssignment.startHour.minute)}')
                                                          .replaceFirst('{{ endHour }}',
                                                              '${normalizeTime(selectedAssignment.endHour.hour)}:${normalizeTime(selectedAssignment.endHour.minute)}'),
                                                      style: TextStyle(color: Theme.of(context).highlightColor));
                                                })))
                                          : Text(
                                              'Total: ${availability.price} €',
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                            )),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                                    textColor: Theme.of(context).backgroundColor,
                                    color: Theme.of(context).primaryColor,
                                    onPressed: availability.price != null
                                        ? () {
                                            Navigator.pushNamed(
                                              context,
                                              Routes.ACUDIER_CONFIRM,
                                              arguments: AcudierConfirmArguments(
                                                acudier: acudier,
                                                hospital: hospital,
                                              ),
                                            );
                                          }
                                        : null,
                                    child: new Text(translate(context, 'request')),
                                  )
                                ],
                              )),
                    ))
              ]);
            }));
  }
}
