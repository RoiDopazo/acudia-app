import 'package:acudia/components/cards/request/request_card.dart';
import 'package:acudia/utils/constants.dart';
import 'package:flutter/material.dart';

class IncomingRequestCard extends StatelessWidget {
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

  const IncomingRequestCard(
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
      this.onPress})
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
              borderRadius: BorderRadius.circular(16),
              color: status.index == REQUEST_STATUS.ACCEPTED.index
                  ? Theme.of(context).primaryColor.withOpacity(0.7)
                  : status.index == REQUEST_STATUS.REJECTED.index
                      ? Theme.of(context).errorColor.withOpacity(0.7)
                      : Theme.of(context).highlightColor.withOpacity(0.7)),
          child: Icon(
              status.index == REQUEST_STATUS.ACCEPTED.index
                  ? Icons.thumb_up_outlined
                  : status.index == REQUEST_STATUS.REJECTED.index
                      ? Icons.thumb_down_outlined
                      : Icons.watch_later_outlined,
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6)),
        ));
  }
}
