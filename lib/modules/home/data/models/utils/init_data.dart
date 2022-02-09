import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/home/data/models/utils/bottom_bar_item.dart';
import 'package:flutter_base/modules/home/data/models/utils/sub_section_item.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/home_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/profile_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/quran_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/search_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/coming_soon/coming_soon_page.dart';
import 'package:flutter_base/modules/messages/presentation/pages/messages/messages_page.dart';
import 'package:flutter_base/modules/teachers/presentation/page/teacher_page.dart';

final List<SubSectionItem> subSectionData = [
  SubSectionItem(
    title: translate('Messages'),
    image: AppIcons.mailIcon,
    action: MessagesPage.routeName,
  ),
  SubSectionItem(
    title: translate('Teachers'),
    image: AppIcons.teacherIcon,
    subTitle: 'Ahmed Mohammed',
    action: TeacherPage.routeName,
  ),
  SubSectionItem(
    title: translate('Students'),
    image: AppIcons.readingIcon,
    action: ComingSoonPage.routeName,
  ),
  SubSectionItem(
    title: translate('Translation'),
    image: AppIcons.languageIcon,
    action: ComingSoonPage.routeName,
  ),
  SubSectionItem(
    title: translate('Tafsir'),
    image: AppIcons.mailIcon,
    action: ComingSoonPage.routeName,
  ),
];

final List<String> data = [
  AppImages.ads2Image,
  AppImages.adsImage,
  AppImages.ads2Image,
  AppImages.adsImage,
  AppImages.ads2Image,
];

List<BottomBarData> homeMenuItems = [
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
