import 'package:acudia/app_localizations.dart';
import 'package:acudia/core/entity/hospital_entity.dart';
import 'package:acudia/core/providers/assignment_provider.dart';
import 'package:acudia/core/providers/search_provider.dart';
import 'package:acudia/ui/screens/main/hospital/search/hospital_list_item.dart';
import 'package:acudia/ui/screens/main/hospital/search/hospital_search_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HospitalSearchPage extends StatelessWidget {
  final bool isAssignment;

  final ScrollController _scrollController = new ScrollController();
  final TextEditingController _searchController = new TextEditingController();
  final FocusNode _searchFocusNode = new FocusNode();

  HospitalSearchPage({this.isAssignment = false});

  @override
  Widget build(BuildContext context) {
    void _scrollListener() {
      var triggerFetchMoreSize = 0.95 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        Provider.of<SearchProvider>(context, listen: false).getMoreItems();
      }
    }

    _scrollController..addListener(_scrollListener);

    Provider.of<SearchProvider>(context, listen: false).fetchHospitals();

    filterButton({String title, String filterKey, List<String> filterList, bool isLoading, BuildContext context}) {
      final bool isActive = filterList.indexOf(filterKey) != -1;
      return new ButtonTheme(
        height: 10.0,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), side: BorderSide(color: Theme.of(context).accentColor)),
          textColor: isActive == true ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).accentColor,
          color: isActive == true ? Theme.of(context).accentColor : Theme.of(context).scaffoldBackgroundColor,
          onPressed: () {
            if (!isLoading) {
              Provider.of<SearchProvider>(context, listen: false).toggleFilter(filterKey);
            }
          },
          child: new Text(title),
        ),
      );
    }

    floatingButtton({Hospital selectedHospital}) {
      if (selectedHospital == null) {
        return FloatingActionButton.extended(
          onPressed: null,
          label: Text(translate(context, 'hospital_search_no_hosp_selected'), style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.grey[400],
        );
      } else {
        return FloatingActionButton.extended(
            onPressed: () {
              Provider.of<AssignmentsProvider>(context, listen: false).moveToConfig(false);
            },
            label: Row(children: [
              Text(translate(context, 'next'), style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: Theme.of(context).scaffoldBackgroundColor),
            ]),
            backgroundColor: Theme.of(context).primaryColor);
      }
    }

    return Consumer<SearchProvider>(
      builder: (context, searchProvider, child) => Scaffold(
        appBar: HospitalSearchAppBar(
          isSearching: searchProvider.isSearching,
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
                      child: new ListView(scrollDirection: Axis.horizontal, children: [
                        filterButton(
                            title: translate(context, 'hospital_search_filters_near'),
                            filterKey: FILTER_IS_NEAR,
                            filterList: searchProvider.filters,
                            isLoading: searchProvider.isLoading,
                            context: context),
                        SizedBox(width: 8),
                        filterButton(
                            title: translate(context, 'hospital_search_filters_hosp_general'),
                            filterKey: FILTER_HOSP_GEN,
                            filterList: searchProvider.filters,
                            isLoading: searchProvider.isLoading,
                            context: context),
                        SizedBox(width: 8),
                        filterButton(
                            title: translate(context, 'hospital_search_filters_hosp_specific'),
                            filterKey: FILTER_HOSP_SPE,
                            filterList: searchProvider.filters,
                            isLoading: searchProvider.isLoading,
                            context: context),
                        SizedBox(width: 8),
                        filterButton(
                            title: translate(context, 'hospital_search_filters_private'),
                            filterKey: FILTER_PRIVATE,
                            filterList: searchProvider.filters,
                            isLoading: searchProvider.isLoading,
                            context: context),
                      ]),
                    ),
                  ],
                )),
            if (searchProvider.isLoading)
              Container(
                  height: MediaQuery.of(context).size.height - 240,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))
            else
              for (Hospital hospital in searchProvider.paginatedList)
                HospitalListItem(
                    hospital: hospital,
                    isAssigment: isAssignment,
                    isSelected: isAssignment &&
                        searchProvider.selected != null &&
                        hospital.codCNH == searchProvider.selected.codCNH)
          ],
        ),
        floatingActionButton: isAssignment ? floatingButtton(selectedHospital: searchProvider.selected) : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
