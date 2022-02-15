import 'package:acudia/app_localizations.dart';
import 'package:acudia/components/reviews/review-list.dart';
import 'package:acudia/core/entity/comment_entity.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/core/services/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class AcudierProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, profile, child) => Query(
            options:
                QueryOptions(documentNode: gql(GRAPHQL_GET_PROFILE_COMMENTS_QUERY), variables: {"role": "ACUDIER"}),
            builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.loading) {
                return Container();
              }

              List<Comment> comments = Comment.fromJsonList(result.data['getComments']['items']);

              return Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                height: 60,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Trabajos \ncompletados",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)))),
                            SizedBox(height: 12),
                            Text("${profile.profile.jobsCompleted.toStringAsFixed(0)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18, color: Theme.of(context).primaryColor))
                          ]),
                      Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                        Container(
                            height: 60,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("Popularidad",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)))),
                        SizedBox(height: 12),
                        SmoothStarRating(
                          rating: profile.profile.popularity,
                          size: 24.0,
                          isReadOnly: true,
                          color: Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                        ),
                      ])
                    ]),
                    Divider(height: 48, thickness: 2),
                    comments.length > 0
                        ? Container(
                            child: Text(translate(context, 'latest_reviews'),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                )))
                        : Text("Sin valoraciones"),
                    SizedBox(height: 12),
                    ReviewList(comments: comments.sublist(0, comments.length >= 3 ? 2 : comments.length))
                  ]));
            }));
  }
}
