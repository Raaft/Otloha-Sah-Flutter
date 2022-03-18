import 'package:flutter/material.dart';

import '../coming_soon/coming_soon_page.dart';

class SearchBNBPage extends StatefulWidget {
  const SearchBNBPage({Key? key}) : super(key: key);

  @override
  State<SearchBNBPage> createState() => _SearchBNBPageState();
}

class _SearchBNBPageState extends State<SearchBNBPage> {

  @override
  Widget build(BuildContext context) {
    return  const ComingSoonPage(); /*Column(
      children: [
        _topView(context),
        _searchBox(),
        _getSearchTarget(),
        _viewItems()
      ],
    );*/
  }






}
