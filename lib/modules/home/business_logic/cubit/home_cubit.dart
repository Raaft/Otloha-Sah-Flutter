import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/home/data/models/utils/bottom_bar_item.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/home_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/profile_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/quran_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/search_bnb_page.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

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

  changeIndex(int? index) {
    emit(HomeIndex(items[index ?? 0], index ?? 0));
  }
}
