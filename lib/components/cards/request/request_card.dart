import 'package:acudia/components/image/image_thumbnail.dart';
import 'package:acudia/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestCard extends StatelessWidget {
  final String name;
  final String hospName;
  final String photoUrl;
  final TimeOfDay startHour;
  final TimeOfDay endHour;
  final DateTime startDate;
  final DateTime endDate;
  final double price;
  final Function onPress;
  final Widget leftComponent;

  const RequestCard(
      {Key key,
      this.name,
      this.hospName,
      this.photoUrl,
      this.startDate,
      this.endDate,
      this.startHour,
      this.endHour,
      this.price,
      this.onPress,
      this.leftComponent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onPress(),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(1, 1),
                colors: [Theme.of(context).backgroundColor, Theme.of(context).scaffoldBackgroundColor],
                tileMode: TileMode.repeated,
              ),
            ),
            margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: IntrinsicHeight(
                child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              leftComponent,
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text(DateFormat.yMMMd('es').format(startDate)), Text("$price €")],
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${normalizeTime(startHour.hour)}:${normalizeTime(startHour.minute)}'),
                              SizedBox(width: 4),
                              Text('-'),
                              SizedBox(width: 4),
                              Text('${normalizeTime(endHour.hour)}:${normalizeTime(endHour.minute)}')
                            ],
                          ),
                          SizedBox(height: 12),
                          Divider(height: 4, thickness: 1),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text("$name"), SizedBox(height: 4), Text("$hospName")]),
                              AcudiaImageThumbnail(photoUrl: photoUrl, small: true, fallbackText: "${name[0]}")
                            ],
                          )
                        ],
                      )))
            ]))));
  }
}
