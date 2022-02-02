import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_base/modules/home/data/models/utils/bottom_bar_item.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/home_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/profile_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/quran_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/search_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/widget/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  static List<BottomBarData> items = [
    BottomBarData(
      title: translate('Home'),
      iconData: AppIcons.homeIcon,
      badgeColor: AppColor.bottomHome,
      page: const HomeBNBPage(),
    ),
    BottomBarData(
      title: translate('Quran'),
      iconData: AppIcons.quranIcon,
      badgeColor: AppColor.bottomSaved,
      page: const QuranBNBPage(),
    ),
    BottomBarData(
      title: translate('Search'),
      iconData: AppIcons.searchIcon,
      badgeColor: AppColor.bottomMenu,
      page: const SearchBNBPage(),
    ),
    BottomBarData(
      title: translate('Profile'),
      iconData: AppIcons.profileIcon,
      badgeColor: AppColor.bottomMenu,
      page: const ProfileBNBPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: items[_index].page,
      ),
      bottomNavigationBar: BubbleBottomBarApp(
        onItemTapped: _changePage,
        selectedIndex: _index,
        items: HomeCubit.items,
      ),
    );
  }

  _changePage(int? index) {
    setState(() {
      _index = index ?? 0;
    });
  }
}
