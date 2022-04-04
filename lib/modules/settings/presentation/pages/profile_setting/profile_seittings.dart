import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../business_logic/settings/settings_cubit.dart';
import 'update_email.dart';
import 'update_phone.dart';
import 'update_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/themes/color.dart';
import '../../../../../../core/widgets/tool_bar_app.dart';
import '../../../../../core/widgets/text_view.dart';
import 'change_password.dart';

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

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextViewIcon(
                        icon: Icon(
                          Icons.person,
                          color: AppColor.txtColor3,
                        ),
                        text: tr('Update Profile'),
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
                      child: TextViewIcon(
                        icon: Icon(
                          Icons.email,
                          color: AppColor.txtColor3,
                        ),
                        text: tr('Update Email'),
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
                      child: TextViewIcon(
                        icon: Icon(
                          Icons.phone,
                          color: AppColor.txtColor3,
                        ),
                        text: tr('Update Phone'),
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
                      child: TextViewIcon(
                        icon: Icon(Icons.security_rounded,
                            color: AppColor.txtColor3),
                        text: tr('Change Password'),
                        textAlign: TextAlign.start,
                        colorText: AppColor.txtColor3,
                        sizeText: 17,
                        weightText: FontWeight.bold,
                        action: () {
                          Get.to(() => ChangePassword());
                        },
                      ),
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
      title: tr('Profile Settings'),
    );
  }
}
