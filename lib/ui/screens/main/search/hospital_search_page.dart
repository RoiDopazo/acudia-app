import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/ui/screens/main/search/hospital_list_item.dart';
import 'package:acudia/ui/screens/main/search/hospital_search_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HospitalSearchPage extends StatelessWidget {
  final ScrollController _scrollController = new ScrollController();
  final TextEditingController _searchController = new TextEditingController();
  final FocusNode _searchFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    void _scrollListener() {
      var triggerFetchMoreSize =
          0.95 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        Provider.of<HospitalProvider>(context, listen: false).getMoreItems();
      }
    }

    _scrollController..addListener(_scrollListener);

    Provider.of<HospitalProvider>(context, listen: false).fetchHospitals();

    return Consumer<HospitalProvider>(
        builder: (context, hospProvider, child) => Scaffold(
            appBar: HospitalSearchAppBar(
              isSearching: hospProvider.isSearching,
              appBar: AppBar(),
              searchController: _searchController,
              searchFocusNode: _searchFocusNode,
            ),
            body: ListView(
              controller: _scrollController,
              children: <Widget>[
                if (hospProvider.isLoading)
                  Container(
                      height: MediaQuery.of(context).size.height - 140,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ))
                else
                  for (var hospital in hospProvider.paginatedList)
                    HospitalListItem(
                        name: hospital.name,
                        location:
                            "${hospital.municipallity} - ${hospital.province}"),
              ],
            )));
  }
}
