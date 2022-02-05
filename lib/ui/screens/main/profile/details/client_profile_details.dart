import 'package:acudia/components/image/image_thumbnail.dart';
import 'package:acudia/core/providers/profile_provider.dart';
import 'package:acudia/core/services/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClientProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, profile, child) => Query(
            options: QueryOptions(documentNode: gql(GRAPHQL_GET_PROFILE_STATS_QUERY), variables: {"role": "CLIENT"}),
            builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.loading) {
                return Container();
              }

              int jobsCompleted = result.data["getProfileStats"]["jobsCompleted"];
              String acudierName = result.data["getProfileStats"]["acudier"]['name'];
              String acudierPhoto = result.data["getProfileStats"]["acudier"]['photoUrl'];
              String hospName = result.data["getProfileStats"]["hosp"]['name'];

              return Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                          Container(
                              height: 60,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Trabajos \ncompletados",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)))),
                          SizedBox(height: 12),
                          Text("${jobsCompleted.toStringAsFixed(0)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18, color: Theme.of(context).primaryColor))
                        ]),
                        Container(
                            child: jobsCompleted != 0
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Divider(height: 48, thickness: 2),
                                        Text('Acudier preferido',
                                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
                                        SizedBox(height: 8),
                                        Row(children: [
                                          AcudiaImageThumbnail(
                                            photoUrl: acudierPhoto,
                                            fallbackText: acudierName[0].toUpperCase(),
                                            small: true,
                                          ),
                                          SizedBox(width: 16),
                                          Text(acudierName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))
                                        ]),
                                        SizedBox(height: 32),
                                        Text('Hospital preferido',
                                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
                                        SizedBox(height: 8),
                                        Row(children: [
                                          SvgPicture.asset('assets/media/icon_hospital.svg', height: 48),
                                          SizedBox(width: 16),
                                          Text(hospName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                                        ]),
                                      ])
                                : Container())
                      ]));
            }));
  }
}
