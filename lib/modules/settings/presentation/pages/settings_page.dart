import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../data_source/models/setting_model/init_data.dart';
import '../../../auth_module/business_logic/auth_cubit.dart';
import '../../../auth_module/presentation/pages/onboard_page.dart';
import 'profile_setting/profile_seittings.dart';
import 'profile_setting/register_as_techer.dart';
import '../widgets/item_setting.dart';
import '../widgets/item_setting_sub.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constant/utils.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';
import '../../../../core/widgets/tool_bar_app.dart';

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
                _titleSection(tr('Main Section')),
                _mainSettings(context),
                const Divider(),
                _titleSection(tr('Download Center')),
                _downloadSettings(context),
                const Divider(),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    var cubit = AuthCubit.get(context);
                    return (cubit.isLogin)
                        ? _titleSection(tr('Settings'))
                        : const Text('');
                  },
                ),
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  var cubit = AuthCubit.get(context);
                  return (cubit.isLogin)
                      ? TextViewIcon(
                    icon: Icon(
                      Icons.settings_outlined,
                      color: AppColor.txtColor3,
                    ),
                    text: tr('Profile Settings'),
                    textAlign: TextAlign.start,
                    colorText: AppColor.txtColor3,
                    sizeText: 17,
                    weightText: FontWeight.bold,
                    action: () {
                      Get.to(() => ProfileSettings());
                    },
                  )
                      : const Text('');
                }),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    var cubit = AuthCubit.get(context);

                    return (cubit.isLogin)
                        ?  TextViewIcon(
                      text: tr('Register up As Teacher'),
                      textAlign: TextAlign.start,
                      colorText: AppColor.txtColor3,
                      sizeText: 17,
                      weightText: FontWeight.w700,
                      icon: Icon(
                        Icons.person_add_alt,
                        color: AppColor.txtColor3,
                      ),
                      action: () {
                        Get.to(const RegisterAsTeacher());
                      },
                    ): const Text('');
                  },
                ),
                BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                  if (state is LogOutSuccessState) {
                    var cubit = AuthCubit.get(context);

                    cubit.changeIsLogin().then((value) {
                      Get.to(() => const OnBoardPage());
                    });
                  }
                }, builder: (context, state) {
                  var cubit = AuthCubit.get(context);

                  return (cubit.isLogin)
                      ? TextViewIcon(
                    text: tr('Log Out'),
                    textAlign: TextAlign.start,
                    colorText: AppColor.txtColor3,
                    sizeText: 17,
                    weightText: FontWeight.w700,
                    icon: Icon(
                      Icons.logout,
                      color: AppColor.txtColor3,
                    ),
                    action: () {
                      cubit.userLogOut();
                      if (state is LogOutSuccessState) {
                        cubit.changeIsLogin();
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
