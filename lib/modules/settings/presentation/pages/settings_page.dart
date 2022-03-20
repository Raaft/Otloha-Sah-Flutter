import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/auth_module/business_logic/auth_cubit.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/onboard_page.dart';
import 'package:flutter_base/modules/settings/data/models/init_data.dart';
import 'package:flutter_base/modules/settings/presentation/pages/profile_setting/profile_seittings.dart';

import 'package:flutter_base/modules/settings/presentation/widgets/item_setting.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/item_setting_sub.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constant/constants.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';
import '../../../home/business_logic/cubit/home_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shrinkWrap: true,
          children: [
            _topView(context),
            _titleSection('Main Section'),
            _mainSettings(context),
            const Divider(),
            _titleSection('Download Center'),
            _downloadSettings(context),
            const Divider(),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                var homeCubit = HomeCubit.get(context);
                return (isLogin) ? _titleSection('Settings') : const Text('');
              },
            ),
            BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
              var homeCubit = HomeCubit.get(context);
              return (isLogin)
                  ? TextView(
                      text: 'Update Profile',
                      textAlign: TextAlign.start,
                      colorText: AppColor.txtColor3,
                      sizeText: 19,
                      weightText: FontWeight.bold,
                      action: () {
                        Get.to(() => ProfileSettings());
                      },
                    )
                  : const Text('');
            }),
            BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
              if (state is LogOutSuccessState) {
                var cubit = AuthCubit.get(context);

                cubit.changeIsLogin(isLog: false).then((value) {
                  Get.to(() => const OnBoardPage());
                });
              }
            }, builder: (context, state) {
              var cubit = AuthCubit.get(context);

              return (isLogin)
                  ? TextViewIcon(
                      text: 'Log Out',
                      textAlign: TextAlign.start,
                      colorText: AppColor.txtColor3,
                      sizeText: 19,
                      weightText: FontWeight.w700,
                      icon: Icon(
                        Icons.logout,
                        color: AppColor.txtColor3,
                      ),
                      action: () {
                        cubit.userLogOut();
                        if (state is LogOutSuccessState) {
                          cubit.changeIsLogin(isLog: false);
                        }
                      },
                    )
                  : const Text('');
            })
          ]),
    ));
  }

  SizedBox _titleSection(String title) {
    return SizedBox(
      width: double.infinity,
      child: TextView(
        text: translate(title),
        colorText: AppColor.txtColor3,
        sizeText: 14,
        weightText: FontWeight.w700,
        padding: const EdgeInsets.all(4),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _topView(BuildContext context) {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: translate('Settings'),
    );
  }

  _mainSettings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: settings.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 2 / 2,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          return ItemSetting(
            settings: settings[index],
            change: _change,
          );
        },
      ),
    );
  }

  _change() {
    setState(() {
      settings;
      downLoadSettings;
    });
  }

  _downloadSettings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: downLoadSettings.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 2 / 2,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          return ItemSetting(
            settings: downLoadSettings[index],
            change: _change,
          );
        },
      ),
    );
  }

  setting(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: settings.length,
      itemBuilder: (context, index) {
        return ItemSubSetting(settings: settings[index]);
      },
    );
  }
}
