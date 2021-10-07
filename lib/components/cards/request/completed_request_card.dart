import 'package:acudia/app_localizations.dart';
import 'package:acudia/components/cards/request/request_card.dart';
import 'package:acudia/utils/constants.dart';
import 'package:flutter/material.dart';

class CompletedRequestCard extends StatelessWidget {
  final String name;
  final String hospName;
  final String photoUrl;
  final REQUEST_STATUS status;
  final TimeOfDay startHour;
  final TimeOfDay endHour;
  final DateTime startDate;
  final DateTime endDate;
  final double price;
  final Function onPress;
  final bool hasFinished;

  const CompletedRequestCard(
      {Key key,
      this.name,
      this.hospName,
      this.photoUrl,
      this.status,
      this.startDate,
      this.endDate,
      this.startHour,
      this.endHour,
      this.price,
      this.onPress,
      this.hasFinished})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RequestCard(
        endDate: this.endDate,
        name: this.name,
        hospName: this.hospName,
        photoUrl: this.photoUrl,
        startDate: this.startDate,
        startHour: this.startHour,
        endHour: this.endHour,
        price: this.price,
        onPress: this.onPress,
        leftComponent: Container(
            width: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Theme.of(context).accentColor.withOpacity(0.7)),
            child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: new RotatedBox(
                    quarterTurns: 3,
                    child: new Text(
                      translate(context, "completed_request"),
                      style: TextStyle(fontSize: 14, color: Theme.of(context).scaffoldBackgroundColor),
                      textAlign: TextAlign.center,
                    )))));
  }
}
