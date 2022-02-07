import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/indicator.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/home/data/models/utils/init_data.dart';
import 'package:flutter_base/modules/home/presentation/widget/ads_item_view.dart';
import 'package:flutter_base/modules/home/presentation/widget/home_main_sction.dart';
import 'package:flutter_base/modules/home/presentation/widget/home_sub_main_sction.dart';
import 'package:flutter_base/modules/home/presentation/widget/progressindicator.dart';
import 'package:flutter_base/modules/home/presentation/widget/user_progress_reading.dart';

class HomeBNBPage extends StatefulWidget {
  const HomeBNBPage({Key? key}) : super(key: key);

  @override
  State<HomeBNBPage> createState() => _HomeBNBPageState();
}

class _HomeBNBPageState extends State<HomeBNBPage> {
  int postion = 0;

  final pageIndexNotifier = ValueNotifier<int>(0);

  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          _toolBarFun(),
          const SizedBox(height: 4),
          _headerProgress(),
          const SizedBox(height: 32),
          _sectionMain(context),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextView(
              text: 'Popular Actions',
              colorText: AppColor.txtColor3,
              sizeText: 16,
              weightText: FontWeight.w700,
              padding: const EdgeInsets.all(4),
              textAlign: TextAlign.start,
            ),
          ),
          _subSections(context),
          const SizedBox(height: 8),
          _adsConView(context),
        ],
      ),
    );
  }

  Container _adsConView(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(children: [
        PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              postion = index;
            });
            pageIndexNotifier.value = index;
          },
          children:
              data.map((dataModel) => _itemPageView(image: dataModel)).toList(),
        ),
        Align(
          alignment: const Alignment(0, 0.65),
          child: Indicator(size: data.length, current: postion),
        ),
      ]),
    );
  }

  Widget _subSections(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        padding: const EdgeInsets.all(4),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: subSectionData.length,
        itemBuilder: (ctx, index) =>
            HomeSubMainSection(item: subSectionData[index]),
      ),
    );
  }

  Row _sectionMain(BuildContext context) {
    return Row(
      children: [
        _sections(
          context,
          'Khatema',
          AppIcons.discussioncon,
          AppColor.gradient3,
          AppColor.gradient1,
        ),
        _sections(
          context,
          'Recitations',
          AppIcons.discussioncon,
          AppColor.gradient3,
          AppColor.gradient4,
        ),
        _sections(
          context,
          'Tajweed',
          AppIcons.quran2Icon,
          AppColor.gradient1,
          AppColor.gradient2,
        ),
      ],
    );
  }

  _sections(
    BuildContext context,
    String title,
    String image,
    Color gradient1,
    Color gradient2,
  ) {
    return HomeMainSection(
      title: title,
      image: image,
      gradient1: gradient1,
      gradient2: gradient2,
      userProgressIndicator: UserProgressIndicator(
        name: 'Shady',
        type: 'Juz1-3',
        value: .57,
      ),
    );
  }

  Row _headerProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: translate('Hello'),
              colorText: AppColor.txtColor4,
              sizeText: 18,
              padding: const EdgeInsets.all(2),
              textAlign: TextAlign.start,
            ),
            TextView(
              text: 'Shady',
              colorText: AppColor.txtColor1,
              sizeText: 20,
              weightText: FontWeight.w900,
              padding: const EdgeInsets.all(2),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        UserProgressReading(
          userProgressIndicator: UserProgressIndicator(
            name: 'Shady',
            type: 'Juz1-3',
            value: .57,
            width: MediaQuery.of(context).size.width * .35,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _toolBarFun() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColor.conColor3,
          foregroundImage: AssetImage(AppImages.duserImage),
        ),
        const Expanded(child: SizedBox()),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.notifications_active_outlined,
            size: 28,
            color: AppColor.iconColor,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.settings_outlined,
            size: 28,
            color: AppColor.iconColor,
          ),
        ),
      ],
    );
  }

  Widget _itemPageView({required String image, Function()? action}) {
    return AdsItemView(
      image: image,
      action: action,
    );
  }
}
