import 'package:acudia/app_localizations.dart';
import 'package:acudia/components/animation/animation_blinking.dart';
import 'package:acudia/core/entity/request_entity.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/core/providers/request_provider.dart';
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

    bool shouldShowAction = (isClient &&
            (request.status.index == REQUEST_STATUS.REJECTED.index ||
                (request.status.index == REQUEST_STATUS.PENDING.index && request.hasStarted) ||
                (request.status.index == REQUEST_STATUS.ACCEPTED.index && request.hasFinished))) ||
        (!isClient && request.status.index == REQUEST_STATUS.PENDING.index && !request.hasStarted);

    dynamic computedLabelData = getLabelColor(context, request.status, request.hasFinished, request.hasStarted);

    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
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
            SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset('assets/media/icon_agreement_outlined.svg', height: 24, color: computedLabelData[0]),
              SizedBox(width: 12),
              BlinkingAnimation(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: computedLabelData[0],
                        ),
                      ),
                      child: Text(computedLabelData[1].toString().toUpperCase(),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: getLabelColor(
                                  context, request.status, request.hasFinished, request.hasStarted)[0])))),
              SizedBox(width: 12),
              SvgPicture.asset('assets/media/icon_agreement_outlined.svg', height: 24, color: computedLabelData[0]),
            ]),
            SizedBox(height: 12),
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
            SizedBox(height: 16),
            Divider(height: 4, thickness: 1),
            SizedBox(height: 16),
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
            SizedBox(height: 16),
            Divider(height: 4, thickness: 1),
            SizedBox(height: 16),
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
          ]))),
          Divider(height: shouldShowAction ? 2 : 0, thickness: 2, color: computedLabelData[0]),
          shouldShowAction
              ? FlatButton(
                  height: shouldShowAction
                      ? isClient
                          ? 56
                          : 72
                      : 0,
                  minWidth: MediaQuery.of(context).size.width,
                  color: computedLabelData[0].withOpacity(0.05),
                  onPressed: () {
                    if (isClient) {
                      if (request.status.index == REQUEST_STATUS.ACCEPTED.index) {
                        onShowDialog(context, request);
                      } else {
                        Provider.of<RequestProvider>(context).removeRequest(context, request);
                      }
                    }
                  },
                  child: isClient
                      ? Text(computedLabelData[2],
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: computedLabelData[0]))
                      : Row(mainAxisSize: MainAxisSize.max, children: [
                          Expanded(
                            child: Container(
                                height: 46,
                                child: RaisedButton(
                                    color: Theme.of(context).errorColor.withOpacity(0.6),
                                    onPressed: () {
                                      Provider.of<RequestProvider>(context).answerRequest(context, request, false);
                                    },
                                    child: Text(translate(context, "deny")))),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                              child: Container(
                                  height: 46,
                                  child: RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      Provider.of<RequestProvider>(context).answerRequest(context, request, true);
                                    },
                                    child: Text(translate(context, "accept")),
                                  )))
                        ]),
                )
              : Container(),
        ]));
  }
}

getLabelColor(context, REQUEST_STATUS status, bool hasFinished, bool hasStarted) {
  if (status.index == REQUEST_STATUS.ACCEPTED.index) {
    return hasFinished == true
        ? [
            Theme.of(context).accentColor,
            translate(context, 'inprogress_complete_request'),
            translate(context, 'end_request')
          ]
        : [Theme.of(context).primaryColor, translate(context, "inprogress_request"), ''];
  }
  if (status.index == REQUEST_STATUS.COMPLETED.index) {
    return [Theme.of(context).accentColor, translate(context, 'inprogress_complete_request'), ''];
  }

  if (status.index == REQUEST_STATUS.REJECTED.index || hasStarted) {
    return [Theme.of(context).errorColor, translate(context, "rejected"), translate(context, 'remove_request')];
  }
  if (status.index == REQUEST_STATUS.PENDING.index) {
    return [Theme.of(context).highlightColor, translate(context, "pending"), ''];
  }
}

onShowDialog(BuildContext context, Request request) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => Consumer<RequestProvider>(
        builder: (context, requestProvider, child) => AlertDialog(
              title: Text(translate(context, 'review_our_acudier')),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                SmoothStarRating(
                  rating: requestProvider.rating,
                  size: 44.0,
                  isReadOnly: false,
                  onRated: (value) => Provider.of<RequestProvider>(context).setRating(value),
                  color: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).accentColor,
                ),
                SizedBox(height: 24),
                TextField(
                  maxLines: 5,
                  onChanged: (String value) {
                    Provider.of<RequestProvider>(context).setComment(value);
                  },
                  decoration: InputDecoration.collapsed(hintText: translate(context, 'leave_a_comment')),
                ),
              ]),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: Text(translate(context, 'cancel')),
                ),
                TextButton(
                  onPressed: requestProvider.hasChange == false
                      ? null
                      : () => {Provider.of<RequestProvider>(context).finishRequest(context, request)},
                  child: Text(translate(context, 'send')),
                ),
              ],
            )),
  );
}
