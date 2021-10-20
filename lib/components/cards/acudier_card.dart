import 'package:acudia/app_localizations.dart';
import 'package:acudia/colors.dart';
import 'package:acudia/components/image/image_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class AcudierCard extends StatelessWidget {
  final String name;
  final String secondName;
  final String photoUrl;
  final int age;
  final double numJobs;
  final double popularity;
  final Function onPress;

  const AcudierCard(
      {Key key, this.name, this.secondName, this.photoUrl, this.age, this.numJobs, this.popularity, this.onPress})
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
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 5,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(1, 1),
                colors: [aCPalette.shade200, Theme.of(context).primaryColor],
                tileMode: TileMode.repeated,
              ),
            ),
            margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      AcudiaImageThumbnail(photoUrl: photoUrl, fallbackText: "${name[0] ?? ''}$secondName"),
                      SizedBox(width: 16),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                            width: MediaQuery.of(context).size.width - 180,
                            child: Text('$name $secondName',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white, fontSize: 22))),
                        SizedBox(height: 4),
                        Text(translate(context, 'computed_age').replaceAll('{{ age }}', '$age'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 14))
                      ]),
                    ]),
                    SizedBox(height: 12),
                    Container(
                        width: MediaQuery.of(context).size.width - 80,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(children: [
                                Text('${numJobs.toInt()}', style: TextStyle(color: Colors.white, fontSize: 12)),
                                SizedBox(height: 2),
                                Text(translate(context, 'jobs'),
                                    style: TextStyle(color: Colors.white.withAlpha(210), fontSize: 10))
                              ]),
                              SizedBox(width: 24),
                              Column(children: [
                                if (popularity != null)
                                  SmoothStarRating(
                                    rating: popularity,
                                    size: 16.0,
                                    isReadOnly: true,
                                    color: Colors.white,
                                    borderColor: Colors.white,
                                  ),
                                SizedBox(height: 2),
                                Text(translate(context, 'popularity'),
                                    style: TextStyle(color: Colors.white.withAlpha(210), fontSize: 10))
                              ])
                            ])),
                  ])),
                ]))));
  }
}
