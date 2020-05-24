import 'package:acudia/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';

class SignUpProfile extends StatelessWidget {
  // Future getImage() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(translate(context, 'field_role_label')),
              SizedBox(height: 32),
            ]),
      ),
      ToggleButtons(onPressed: (int index) {}, isSelected: [
        false,
        false,
      ], children: <Widget>[
        Container(
          width: (MediaQuery.of(context).size.width - 52) / 3,
          height: 80,
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(translate(context, 'field_role_client')),
              ]),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 52) / 3,
          height: 80,
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(translate(context, 'field_role_acudier')),
              ]),
        )
      ]),
      SizedBox(height: 16),
      // Container(
      //   width: MediaQuery.of(context).size.width,
      //   child: new Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: <Widget>[
      //         Icon(
      //           Icons.info,
      //           color: Theme.of(context).disabledColor,
      //         ),
      //         SizedBox(width: 16),
      //         Flexible(
      //             child: Text(
      //                 "'Acudier' es el nombre que reciben los usuarios que se ofrezcan como cuidadores")),
      //         SizedBox(height: 32),
      //       ]),
      // ),
      Container(
        width: MediaQuery.of(context).size.width,
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(translate(context, 'field_picture_label')),
              SizedBox(height: 32),
            ]),
      ),
    ]);
  }
}
