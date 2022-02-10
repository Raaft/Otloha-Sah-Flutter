import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/indicator.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/onboard_page.dart';
import 'package:flutter_base/modules/home/data/models/utils/init_data.dart';
import 'package:flutter_base/modules/home/presentation/pages/coming_soon/coming_soon_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/recitations/recitations_page.dart';
import 'package:flutter_base/modules/home/presentation/widget/ads_item_view.dart';
import 'package:flutter_base/modules/home/presentation/widget/home_main_sction.dart';
import 'package:flutter_base/modules/home/presentation/widget/home_sub_main_sction.dart';
import 'package:flutter_base/modules/home/presentation/widget/progressindicator.dart';
import 'package:flutter_base/modules/home/presentation/widget/user_progress_reading.dart';
import 'package:flutter_base/modules/messages/presentation/pages/notify/notifiactions_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings_page.dart';
import 'package:get/get.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _toolBarFun(),
          _headerProgress(),
          _sectionMain(context),
          SizedBox(
            width: double.infinity,
            child: TextView(
              text: translate('PopularActions'),
              colorText: AppColor.txtColor3,
              sizeText: 16,
              weightText: FontWeight.w700,
              padding: const EdgeInsets.all(4),
              textAlign: TextAlign.start,
            ),
          ),
          _subSections(context),
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
      height: MediaQuery.of(context).size.height * .14,
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
          translate('Khatema'),
          AppIcons.discussioncon,
          AppColor.gradient3,
          AppColor.gradient1,
          actionTo: ComingSoonPage.routeName,
        ),
        _sections(
          context,
          translate('Recitations'),
          AppIcons.discussioncon,
          AppColor.gradient3,
          AppColor.gradient4,
          actionTo: RecitationsPage.routeName,
        ),
        _sections(
          context,
          translate('Tajweed'),
          AppIcons.quran2Icon,
          AppColor.gradient1,
          AppColor.gradient2,
          actionTo: ComingSoonPage.routeName,
        ),
      ],
    );
  }

  _sections(
    BuildContext context,
    String title,
    String image,
    Color gradient1,
    Color gradient2, {
    String? actionTo,
  }) {
    return HomeMainSection(
      title: title,
      image: image,
      gradient1: gradient1,
      gradient2: gradient2,
      userProgressIndicator: const UserProgressIndicator(
        name: 'Shady',
        type: 'Juz1-3',
        value: .57,
      ),
      action: () {
        Navigator.of(context).pushNamed(actionTo ?? '');
      },
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
        GestureDetector(
          onTap: () {
            Get.to(const OnBoardPage());
          },
          child: CircleAvatar(
            radius: 24,
            backgroundColor: AppColor.conColor3,
            foregroundImage: AssetImage(AppImages.duserImage),
          ),
        ),
        const Expanded(child: SizedBox()),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(NotifiactionsPage.routeName);
          },
          child: Icon(
            Icons.notifications_active_outlined,
            size: 28,
            color: AppColor.iconColor,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(SettingsPage.routeName);
          },
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
