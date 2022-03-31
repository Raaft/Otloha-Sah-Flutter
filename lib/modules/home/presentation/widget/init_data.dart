import 'package:flutter/material.dart';
import 'package:flutter_base/data_source/cache_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_base/modules/home/presentation/widget/bottom_bar_item.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/home_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/profile_bnb_page.dart';
import 'package:flutter_base/modules/quran/presentation/page/quran_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/bnb_pags/search_bnb_page.dart';
import 'package:flutter_base/modules/home/presentation/widget/sub_section_item.dart';
import 'package:flutter_base/modules/quran/presentation/page/action_pages/pages_liked_page.dart';
import 'package:flutter_base/modules/teachers/presentation/page/students_page.dart';
import 'package:flutter_base/modules/teachers/presentation/page/teacher_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

import '../../../messages/presentation/pages/messages/layout_page.dart';

final List<SubSectionItem> subSectionData = [
  SubSectionItem(
    title: translate('Messages'),
    image: AppIcons.mailIcon,
    action: MessagesPage.routeName,
  ),
  SubSectionItem(
    title: translate('Teachers'),
    image: AppIcons.teacherIcon,
    subTitle: _user(),
    action: TeacherPage.routeName,
  ),
  SubSectionItem(
    title: translate('Students'),
    image: AppIcons.readingIcon,
    action: StudentsPage.routeName,
  ),
  SubSectionItem(
    title: translate('Translation'),
    image: AppIcons.languageIcon,
    subTitle: CacheHelper.getData(key: qtlSelectedName),
    action2: (context) {
      BlocProvider.of<HomeCubit>(context)
          .changePluginPage(page: PageType.translation)
          .then((value) => BlocProvider.of<HomeCubit>(context).changeIndex(1));
    },
  ),
  SubSectionItem(
    title: translate('Tafsir'),
    image: AppIcons.mailIcon,
    subTitle: CacheHelper.getData(key: tafseerSelectedName),
    action2: (context) {
      BlocProvider.of<HomeCubit>(context)
          .changePluginPage(page: PageType.tafsir)
          .then((value) => BlocProvider.of<HomeCubit>(context).changeIndex(1));
    },
  ),
  SubSectionItem(
    title: translate('Tajweed'),
    image: AppIcons.mailIcon,
    action2: (context) {
      BlocProvider.of<HomeCubit>(context)
          .changePluginPage(page: PageType.tajwid)
          .then((value) => BlocProvider.of<HomeCubit>(context).changeIndex(1));
    },
  ),
  SubSectionItem(
    title: translate('Note'),
    image: AppIcons.quran4Icon,
    action2: (context) {
      Navigator.of(context).pushNamed(PagesLikedPage.routeName, arguments: 1);
    },
  ),
  SubSectionItem(
    title: translate('Likes'),
    image: AppIcons.likeIcon,
    action2: (context) {
      Navigator.of(context).pushNamed(PagesLikedPage.routeName, arguments: 3);
    },
  ),
  SubSectionItem(
    title: translate('BookMarks'),
    image: AppIcons.bubbleIcon,
    action2: (context) {
      //Get.to(const PagesBookMarkPage());
      Navigator.of(context).pushNamed(PagesBookMarkPage.routeName, arguments: 2);
    },
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
    page: QuranBNBPage(),
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

String _user() {
  if (favTeacherProFile != null) {
    var str = (favTeacherProFile!.lastName!.isEmpty &&
            favTeacherProFile!.firstName!.isEmpty)
        ? (favTeacherProFile!.username)
        : '';
    return (favTeacherProFile!.firstName ?? '') +
        ' ' +
        (favTeacherProFile!.lastName ?? '') +
        (str ?? '');
  } else {
    return '';
  }
}
