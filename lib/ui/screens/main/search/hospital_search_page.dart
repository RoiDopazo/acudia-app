import 'package:acudia/app_localizations.dart';
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

    filterButton(
        {String title,
        String filterKey,
        List<String> filterList,
        bool isLoading,
        BuildContext context}) {
      final bool isActive = filterList.indexOf(filterKey) != -1;
      return new ButtonTheme(
        height: 10.0,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Theme.of(context).primaryColor)),
          textColor: isActive == true
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).primaryColor,
          color: isActive == true
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
          onPressed: () {
            if (!isLoading) {
              Provider.of<HospitalProvider>(context, listen: false)
                  .toggleFilter(filterKey);
            }
          },
          child: new Text(title),
        ),
      );
    }

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
                Container(
                    height: 60,
                    padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
                    child: new ListView(
                      children: <Widget>[
                        new Container(
                          height: 32.0,
                          child: new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                filterButton(
                                    title: translate(context,
                                        'hospital_search_filters_near'),
                                    filterKey: FILTER_IS_NEAR,
                                    filterList: hospProvider.filters,
                                    isLoading: hospProvider.isLoading,
                                    context: context),
                                SizedBox(width: 8),
                                filterButton(
                                    title: translate(context,
                                        'hospital_search_filters_hosp_general'),
                                    filterKey: FILTER_HOSP_GEN,
                                    filterList: hospProvider.filters,
                                    isLoading: hospProvider.isLoading,
                                    context: context),
                                SizedBox(width: 8),
                                filterButton(
                                    title: translate(context,
                                        'hospital_search_filters_hosp_specific'),
                                    filterKey: FILTER_HOSP_SPE,
                                    filterList: hospProvider.filters,
                                    isLoading: hospProvider.isLoading,
                                    context: context),
                                SizedBox(width: 8),
                                filterButton(
                                    title: translate(context,
                                        'hospital_search_filters_private'),
                                    filterKey: FILTER_PRIVATE,
                                    filterList: hospProvider.filters,
                                    isLoading: hospProvider.isLoading,
                                    context: context),
                              ]),
                        ),
                      ],
                    )),
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