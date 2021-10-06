import 'package:acudia/app_localizations.dart';
import 'package:acudia/colors.dart';
import 'package:acudia/core/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HospitalSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final FocusNode searchFocusNode;
  final TextEditingController searchController;
  final bool isSearching;
  final AppBar appBar;

  HospitalSearchAppBar(
      {@required this.isSearching, @required this.appBar, this.searchController, this.searchFocusNode});

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      brightness: Brightness.dark,
      elevation: 1,
      iconTheme: IconThemeData(color: aCPaletteAccent),
      backgroundColor: Theme.of(context).accentColor,
      title: isSearching == true
          ? TextField(
              focusNode: searchFocusNode,
              controller: searchController,
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {
                Provider.of<SearchProvider>(context, listen: false).searchHospitals(searchValue: value);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: translate(context, 'hospital_search_input_hint'),
                hintStyle:
                    Theme.of(context).textTheme.headline3.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
              ),
              style: Theme.of(context).textTheme.headline3.copyWith(color: Theme.of(context).scaffoldBackgroundColor))
          : Text(translate(context, 'hospital_search_title'),
              style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).scaffoldBackgroundColor)),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              if (isSearching != true) {
                searchController.clear();
              }
              Provider.of<SearchProvider>(context, listen: false).toggleIsSearching(searchValue: searchController.text);
              searchFocusNode.requestFocus();
            },
            icon: Icon(
              isSearching == true ? Icons.cancel : Icons.search,
              color: Theme.of(context).scaffoldBackgroundColor,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
