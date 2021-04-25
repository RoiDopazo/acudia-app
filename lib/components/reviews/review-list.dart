import 'package:acudia/components/image/image_thumbnail.dart';
import 'package:acudia/core/entity/comment_entity.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewList extends StatelessWidget {
  final List<Comment> comments;

  const ReviewList({this.comments});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    comments.forEach((comment) {
      var imageFallback = comment.author.split(' ').map((e) {
        return e[0];
      }).join('');

      widgetList.add(Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              AcudiaImageThumbnail(photoUrl: null, small: true, fallbackText: imageFallback),
              SizedBox(width: 16),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.author,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SmoothStarRating(
                      rating: comment.rating,
                      size: 16.0,
                      isReadOnly: true,
                      color: Theme.of(context).accentColor,
                      borderColor: Theme.of(context).accentColor,
                    ),
                  ])
            ]),
            SizedBox(height: 8),
            Container(
              child: Text(comment.comment),
            )
          ])));
    });

    return Container(child: Column(children: widgetList));
  }
}
