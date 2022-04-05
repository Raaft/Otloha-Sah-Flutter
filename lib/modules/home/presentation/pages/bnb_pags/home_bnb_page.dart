import 'package:flutter/material.dart';
import 'package:flutter_base/core/widgets/cached_image.dart';
import '../../../../../core/utils/constant/utils.dart';
import '../../../../../core/utils/res/icons_app.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../../../core/widgets/auth_navigator.dart';
import '../../../../../core/widgets/indicator.dart';
import '../../../../../core/widgets/text_view.dart';
import '../../../../auth_module/business_logic/auth_cubit.dart';
import '../../../business_logic/cubit/home_cubit.dart';
import '../coming_soon/coming_soon_page.dart';
import '../../widget/ads_item_view.dart';
import '../../widget/home_main_sction.dart';
import '../../widget/home_sub_main_sction.dart';
import '../../widget/init_data.dart';
import '../../widget/progressindicator.dart';
import '../../widget/user_progress_reading.dart';
import '../../../../messages/presentation/pages/notify/notifiactions_page.dart';
import '../../../../recitations/presentation/page/recitations_page.dart';
import '../../../../settings/presentation/pages/settings_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              var authCubit = AuthCubit.get(context);

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _toolBarFun(cubit, authCubit),
                  _headerProgress(cubit, authCubit),
                  _sectionMain(context, authCubit),
                  SizedBox(
                    width: double.infinity,
                    child: Semantics(
                      label: translate('PopularActions'),
                      child: TextView(
                        text: translate('PopularActions'),
                        colorText: AppColor.txtColor3,
                        sizeText: 16,
                        weightText: FontWeight.w700,
                        padding: const EdgeInsets.all(4),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  _subSections(context),
                  _adsConView(context),
                ],
              );
            },
          );
        },
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
      height: MediaQuery.of(context).size.height * .15,
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

  Row _sectionMain(BuildContext context, AuthCubit authCubit) {
    return Row(
      children: [
        _sections(context, translate('Khatema'), AppIcons.discussioncon,
            AppColor.gradient3, AppColor.gradient1,
            actionTo: ComingSoonPage.routeName, authCubit: authCubit),
        _sections(context, translate('Recitations'), AppIcons.discussioncon,
            AppColor.gradient3, AppColor.gradient4,
            actionTo: RecitationsPage.routeName, authCubit: authCubit),
        _sections(context, translate('Tajweed'), AppIcons.quran2Icon,
            AppColor.gradient1, AppColor.gradient2,
            actionTo: ComingSoonPage.routeName, authCubit: authCubit),
      ],
    );
  }

  _sections(BuildContext context, String title, String image, Color gradient1,
      Color gradient2,
      {String? actionTo, required AuthCubit authCubit}) {
    return HomeMainSection(
      title: title,
      image: image,
      gradient1: gradient1,
      gradient2: gradient2,
      userProgressIndicator: UserProgressIndicator(
        name: authCubit.proFile.firstName ?? '',
        type: 'Juz1-3',
        value: 0.0,
      ),
      action: () async {
        AuthNavigator.of(context)!.pushConditionally(context, actionTo!);
      },
    );
  }

  Row _headerProgress(HomeCubit cubit, AuthCubit authCubit) {
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
            if (authCubit.isLogin)
              TextView(
                text: authCubit.proFile.firstName ?? '',
                colorText: AppColor.txtColor1,
                sizeText: 20,
                weightText: FontWeight.w900,
                padding: const EdgeInsets.all(2),
                textAlign: TextAlign.start,
              ),
          ],
        ),
        if (authCubit.isLogin)
          UserProgressReading(
            userProgressIndicator: UserProgressIndicator(
              name: authCubit.proFile.firstName ?? '',
              type: 'Juz1-3',
              value: 0,
              width: MediaQuery.of(context).size.width * .35,
              fontSize: 16,
            ),
          ),
      ],
    );
  }

  Widget _toolBarFun(HomeCubit cubit, AuthCubit authCubit) {
    return Row(
      children: [
        if (authCubit.isLogin)
          GestureDetector(
            onTap: () {
              // Get.to(const OnBoardPage());
            },
            child: CachedImage(url: authCubit.proFile.image ?? '', raduis: 36),
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
