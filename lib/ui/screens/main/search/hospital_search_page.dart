import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/ui/screens/main/search/hospital_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HospitalSearchPage extends StatelessWidget {
  final ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    void _scrollListener() {
      var triggerFetchMoreSize =
          0.98 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        Provider.of<HospitalProvider>(context, listen: false).getMoreItems();
        _scrollController.removeListener(_scrollListener);
      }
    }

    _scrollController..addListener(_scrollListener);

    Provider.of<HospitalProvider>(context, listen: false).fetchHospitals();

    return Consumer<HospitalProvider>(
        builder: (context, hospProvider, child) => ListView(
              controller: _scrollController,
              children: <Widget>[
                if (hospProvider.hospList.length == 0)
                  Container(
                      height: MediaQuery.of(context).size.height - 140,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ))
                else
                  for (var hospital in hospProvider.paginatedList)
                    HospitalCard(
                        name: hospital.name,
                        location:
                            "${hospital.municipallity} - ${hospital.province}"),
              ],
            ));
  }
}
