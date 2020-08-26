import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/providers/hospital_provider.dart';
import 'package:acudia/ui/screens/main/search/hospital_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HospitalSearchPage extends StatelessWidget {
  final ScrollController _scrollController = new ScrollController();
  final FocusNode _searchFocusNode = new FocusNode();

  final TextEditingController _searchController = new TextEditingController();

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
            appBar: AppBar(
              title: hospProvider.isSearching == true
                  ? TextField(
                      focusNode: _searchFocusNode,
                      controller: _searchController,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) {
                        Provider.of<HospitalProvider>(context, listen: false)
                            .searchHospitals(searchValue: value);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search hospital...',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: Colors.white.withAlpha(150)),
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.white))
                  : Text(translate(context, 'hospital_search_title'),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Colors.white)),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      _searchController.clear();
                      Provider.of<HospitalProvider>(context, listen: false)
                          .toggleIsSearching(
                              searchValue: _searchController.text);
                      _searchFocusNode.requestFocus();
                    },
                    icon: Icon(hospProvider.isSearching == true
                        ? Icons.cancel
                        : Icons.search))
              ],
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
