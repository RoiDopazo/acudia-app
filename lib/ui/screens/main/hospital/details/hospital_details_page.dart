import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/ui/screens/main/hospital/details/hospital_details_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HospitalDetailsPage extends StatelessWidget {
  final Hospital hospital;

  HospitalDetailsPage({this.hospital});

  @override
  Widget build(BuildContext context) {
    final HospitalArguments args = ModalRoute.of(context).settings.arguments;

    print(args.hospital.name.length);
    print(MediaQuery.of(context).size.width);

    return Consumer<HospitalProvider>(
      builder: (context, hospProvider, child) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              collapsedHeight: 52,
              toolbarHeight: 50,
              expandedHeight: 180.0,
              floating: false,
              pinned: true,
              backgroundColor: Theme.of(context).accentColor,
              flexibleSpace: FlexibleSpaceBar(
                title: LayoutBuilder(builder: (context, size) {
                  var span = TextSpan(
                      text: args.hospital.name,
                      style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor));

                  return Text.rich(
                    span,
                    overflow: TextOverflow.ellipsis,
                    maxLines: size.maxHeight > 180 ? 3 : 1,
                  );
                }),
              ),
            ),
            SliverFillRemaining(
              child: Center(
                child: Column(
                  children: [Text('dddddd'), Text('ggggggg')],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
