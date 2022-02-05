import 'package:acudia/app_localizations.dart';
import 'package:acudia/colors.dart';
import 'package:acudia/components/image/image_thumbnail.dart';
import 'package:acudia/core/aws/cognito_service.dart';
import 'package:acudia/core/providers/error_notifier_provider.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/routes.dart';
import 'package:acudia/ui/screens/main/profile/details/client_profile_details.dart';
import 'package:acudia/utils/helpers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'details/acudier_profile_details.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logoutButton = new ButtonTheme(
      height: 50.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Theme.of(context).errorColor)),
        padding: const EdgeInsets.all(16.0),
        textColor: Theme.of(context).errorColor,
        color: Theme.of(context).backgroundColor,
        onPressed: () {
          showModal(
              context: context,
              errorTitle: translate(context, "confirm_question"),
              error: translate(context, "confirm_logout"),
              vtype: ERROR_VISUALIZATIONS_TYPE.dialog,
              type: DialogType.WARNING,
              onAccept: () {
                CognitoService.logout();
                Navigator.of(context).pushNamedAndRemoveUntil(Routes.SPLASH, (Route<dynamic> route) => false);
              });
        },
        child: new Text(translate(context, 'auth_logout')),
      ),
    );

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Consumer<ProfileProvider>(
            builder: (context, profile, child) => SingleChildScrollView(
                    child: Column(children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: CustomPaint(
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: MediaQuery.of(context).size.height / 3 + 50,
                                  maxHeight: MediaQuery.of(context).size.height / 3 + 50),
                              child: Column(children: <Widget>[
                                SizedBox(height: 48),
                                Container(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                    child: Row(children: [
                                      AcudiaImageThumbnail(
                                          photoUrl: profile.profile.photoUrl,
                                          fallbackText:
                                              "${profile.profile.name[0] ?? ''}${profile.profile.secondName}"),
                                      SizedBox(width: 24),
                                      Text(profile.profile.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              decoration: TextDecoration.none))
                                    ])),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                      Icon(
                                        Icons.mail,
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                      ),
                                      SizedBox(width: 16),
                                      Text(profile.profile.email,
                                          style: TextStyle(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                          ))
                                    ])),
                                // SizedBox(height: 8),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                      Icon(Icons.calendar_today, color: Theme.of(context).scaffoldBackgroundColor),
                                      SizedBox(width: 16),
                                      Text(
                                          translate(context, 'member_since').replaceAll('{{ date }}',
                                              '${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(profile.profile.createdAt))}'),
                                          style: TextStyle(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                          ))
                                    ])),
                              ])),
                          painter: CurvePainter())),
                  Container(child: profile.profile.isAcudier ? AcudierProfileDetails() : ClientProfileDetails()),
                  Container(child: logoutButton),
                  SizedBox(height: 16),
                ]))));
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = aCPaletteAccent;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width / 2, size.height / 1, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
