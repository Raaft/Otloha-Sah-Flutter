import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/indicator.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/home/presentation/widget/progressindicator.dart';

class HomeBNBPage extends StatefulWidget {
  const HomeBNBPage({Key? key}) : super(key: key);

  @override
  State<HomeBNBPage> createState() => _HomeBNBPageState();
}

class _HomeBNBPageState extends State<HomeBNBPage> {
  final List<DataList> maps = [
    DataList(title: 'Messages', image: AppIcons.mailIcon),
    DataList(
        title: 'Teachers',
        image: AppIcons.teacherIcon,
        subTitle: 'Ahmed Mohammed'),
    DataList(title: 'Students', image: AppIcons.readingIcon),
    DataList(title: 'Translation', image: AppIcons.languageIcon),
    DataList(title: 'Tafsir', image: AppIcons.mailIcon),
    DataList(title: 'Messages', image: AppIcons.quranIcon),
  ];

  int postion = 0;

  final pageIndexNotifier = ValueNotifier<int>(0);

  final List<String> data = [
    AppImages.ads2Image,
    AppImages.adsImage,
    AppImages.ads2Image,
    AppImages.adsImage,
    AppImages.ads2Image,
  ];

  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          _toolBarFun(),
          const SizedBox(height: 8),
          _headerProgress(),
          const SizedBox(height: 8),
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
          _adsConView(context),
        ],
      ),
    );
  }

  Container _adsConView(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .33,
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
          children: data
              .map((dataModel) => _itemPageView(dataModel: dataModel))
              .toList(),
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
      height: 100,
      child: ListView.builder(
        padding: const EdgeInsets.all(4),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: maps.length,
        itemBuilder: (ctx, index) => _subSectionsItems(context, maps[index]),
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
          AppColor.gradient4,
        ),
        _sections(
          context,
          'Recitations',
          AppIcons.discussioncon,
          AppColor.gradient4,
          AppColor.gradient1,
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

  Expanded _sections(
    BuildContext context,
    String title,
    String image,
    Color gradient1,
    Color gradient2,
  ) {
    return Expanded(
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradient1, gradient2],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  image,
                  width: MediaQuery.of(context).size.width * .09,
                  height: 50,
                ),
                GestureDetector(
                    onTap: () {}, child: const Icon(Icons.arrow_forward))
              ],
            ),
            Expanded(
              child: TextView(
                text: title,
                colorText: AppColor.txtColor3,
                sizeText: 16,
                weightText: FontWeight.w700,
                padding: const EdgeInsets.all(0),
                textAlign: TextAlign.end,
              ),
            ),
            const ProgressIndicatorApp(
              name: 'Shady',
              type: 'Juz1-3',
              value: .57,
            ),
          ],
        ),
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
              sizeText: 20,
              padding: const EdgeInsets.all(4),
              textAlign: TextAlign.start,
            ),
            TextView(
              text: 'Shady',
              colorText: AppColor.txtColor1,
              sizeText: 28,
              weightText: FontWeight.w700,
              padding: const EdgeInsets.all(4),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.gradient1, AppColor.gradient2],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const ProgressIndicatorApp(
                name: 'Shady',
                type: 'Juz1-3',
                value: .57,
              ),
              const SizedBox(width: 8),
              Image.asset(
                AppIcons.quranIcon,
                width: 50,
                height: 50,
              )
            ],
          ),
        )
      ],
    );
  }

  Row _toolBarFun() {
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

  _subSectionsItems(BuildContext context, DataList item) {
    return Container(
      height: 80,
      width: 80,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.gradient3, AppColor.gradient4],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            item.image,
            width: 32,
            height: 32,
          ),
          TextView(
            text: item.title,
            colorText: AppColor.txtColor3,
            sizeText: 12,
            weightText: FontWeight.w700,
            padding: const EdgeInsets.all(2),
            textAlign: TextAlign.center,
          ),
          if (item.subTitle != null && item.subTitle!.isNotEmpty)
            TextView(
              text: item.subTitle ?? '',
              colorText: AppColor.txtColor4,
              sizeText: 8,
              padding: const EdgeInsets.all(2),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }

  Widget _itemPageView({required String dataModel}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: Image.asset(
              dataModel,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}

class DataList extends Equatable {
  final String? subTitle;
  final String title;
  final String image;
  const DataList({
    this.subTitle,
    required this.title,
    required this.image,
  });

  @override
  List<Object?> get props => [title, image, subTitle];
}
