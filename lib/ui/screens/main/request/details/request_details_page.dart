import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/entity/request_entity.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/ui/screens/main/request/details/request_details_args.dart';
import 'package:acudia/utils/constants.dart';
import 'package:acudia/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RequestDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RequestDetailsArguments args = ModalRoute.of(context).settings.arguments;
    final Request request = args.request;

    USER_ROLES role = Provider.of<ProfileProvider>(context).profile.role;
    bool isClient = role.toString().split('.')[1] == USER_ROLES.CLIENT.toString().split('.')[1];

    DateFormat dateFormat = DateFormat("d MMM");
    DateFormat dateFormat2 = DateFormat("y");

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: BackButton(color: Theme.of(context).accentColor),
          elevation: 0,
          title: Text(translate(context, "request_details")),
        ),
        body: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
            SizedBox(height: 24),
            Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(children: [
                  SvgPicture.asset('assets/media/acudia_logo.svg', height: 48),
                  SizedBox(width: 12),
                  Container(
                      child: Text('${request.acudierName}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ))),
                ])),
            SizedBox(height: 24),
            Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                      child: Text('${request.clientName}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ))),
                  SizedBox(width: 12),
                  SvgPicture.asset('assets/media/client_logo.svg', height: 48),
                ])),
            SizedBox(height: 24),
            Divider(height: 4, thickness: 1),
            SizedBox(height: 24),
            Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                      width: MediaQuery.of(context).size.width - 96,
                      child: Text(request.hospName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ))),
                  SvgPicture.asset('assets/media/icon_hospital.svg', height: 48),
                ])),
            SizedBox(height: 24),
            Divider(height: 4, thickness: 1),
            SizedBox(height: 24),
            Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                    )),
                child: Column(
                  children: [
                    Text(dateFormat.format(request.from).toUpperCase(),
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                    Text(dateFormat2.format(request.from))
                  ],
                )),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  margin: EdgeInsets.only(right: 48),
                  child: Text(
                    '${normalizeTime(request.startHour.hour)}:${normalizeTime(request.startHour.minute)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )),
              Container(
                  child: Column(
                children: [
                  for (int i in [1, 2, 3, 4, 5, 6, 7, 8])
                    Container(
                      decoration: BoxDecoration(color: Theme.of(context).accentColor, shape: BoxShape.circle),
                      margin: EdgeInsets.all(4),
                      width: 10,
                      height: 10,
                    ),
                ],
              )),
              Container(
                  margin: EdgeInsets.only(left: 48),
                  child: Text('${normalizeTime(request.endHour.hour)}:${normalizeTime(request.endHour.minute)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
            ]),
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                    )),
                child: Column(
                  children: [
                    Text(dateFormat.format(request.to).toUpperCase(),
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                    Text(dateFormat2.format(request.to))
                  ],
                )),
            SizedBox(height: 24),
            Divider(height: 4, thickness: 1),
            SizedBox(height: 24),
            Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(children: [
                  Text(translate(context, "total_price"), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                  Text("${request.price} €", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                ])),
            SizedBox(height: 24),
            Container(
                width: MediaQuery.of(context).size.width - 48,
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Theme.of(context).primaryColor, width: 2, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  color: Theme.of(context).backgroundColor,
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () => {
                    if (isClient == true) {onShowDialog(context)}
                  },
                  child: new Text(translate(context, 'end')),
                ))
          ])))
        ]));
  }
}

onShowDialog(context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(translate(context, 'review_our_acudier')),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        SmoothStarRating(
          size: 36.0,
          isReadOnly: false,
          color: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).accentColor,
        ),
        SizedBox(height: 24),
        TextField(
          maxLines: 5,
          decoration: InputDecoration.collapsed(hintText: translate(context, 'leave_a_comment')),
        ),
      ]),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(translate(context, 'cancel')),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text(translate(context, 'send')),
        ),
      ],
    ),
  );
}
