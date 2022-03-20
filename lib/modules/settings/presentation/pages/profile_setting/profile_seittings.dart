import 'package:flutter/material.dart';
import 'package:flutter_base/modules/settings/business_logic/settings/settings_cubit.dart';
import 'package:flutter_base/modules/settings/presentation/pages/profile_setting/register_as_techer.dart';
import 'package:flutter_base/modules/settings/presentation/pages/profile_setting/update_email.dart';
import 'package:flutter_base/modules/settings/presentation/pages/profile_setting/update_phone.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/constant/utils.dart';
import '../../../../../../core/utils/themes/color.dart';
import '../../../../../../core/widgets/tool_bar_app.dart';
import '../../../../../core/widgets/text_view.dart';
import '../../../data/update_profile_web_servises.dart';
import 'change_Password.dart';

class ProfileSettings extends StatelessWidget {
  ProfileSettings({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (ctx, state) {
        // TODO: implement listener
      },
      builder: (ctx, state) {

        return Scaffold(
          body: SafeArea(
            child: ListView(
              children: [
                topView(context),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextView(
                        text: 'Update Profile',
                        textAlign: TextAlign.start,
                        colorText: AppColor.txtColor3,
                        sizeText: 17,
                        weightText: FontWeight.bold,
                        action: () {
                          Get.to(() => UpdateProfile());
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextView(
                        text: 'Update Email',
                        textAlign: TextAlign.start,
                        colorText: AppColor.txtColor3,
                        sizeText: 17,
                        weightText: FontWeight.bold,
                        action: () {
                          Get.to(() => UpdateEmail());
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextView(
                        text: 'Update Phone',
                        textAlign: TextAlign.start,
                        colorText: AppColor.txtColor3,
                        weightText: FontWeight.bold,
                        sizeText: 17,
                        action: () {
                          Get.to(() => UpdatePhone());
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextView(
                        text: 'Change Password',
                        textAlign: TextAlign.start,
                        colorText: AppColor.txtColor3,
                        sizeText: 17,
                        weightText: FontWeight.bold,
                        action: () {
                          Get.to(() => ChangePassword());
                        },
                      ),
                    ),
                    TextViewIcon(
                      text: 'Register up As Teacher ',
                      textAlign: TextAlign.start,
                      colorText: AppColor.txtColor3,
                      sizeText: 17,
                      weightText: FontWeight.w700,
                      icon: Icon(
                        Icons.person_add_alt,
                        color: AppColor.txtColor3,
                      ),
                      action: () {
                        Get.to(RegisterAsTeacher());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget topView(BuildContext context) {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: translate('Profile Settings'),
    );
  }
}
