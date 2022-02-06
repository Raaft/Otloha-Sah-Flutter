import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/sign_up.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/background_image.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/rounded_button.dart';
import 'package:get/get.dart';

class OnBoardPage extends StatelessWidget {
  static const routeName = '/';

  const OnBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          layoutBackgroundImage(AppImages.backGroundImage),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.6),
                AuthButton(
                  buttonText: 'Login',
                  width: MediaQuery.of(context).size.height * 0.5,
                  onPressed: () {
                    Get.to(LoginPage());
                  },
                  colors: [
                    AppColor.lightYellow,
                    AppColor.lightYellow,
                  ],
                ),
                AuthButton(
                  buttonText: 'Sign up',
                  width: MediaQuery.of(context).size.height * 0.5,
                  onPressed: () {
                    Get.to(SignUpPage());
                  },
                  colors: [
                    AppColor.darkBlue,
                    AppColor.lightBlue,
                  ],
                ),
                AuthButton(
                  buttonText: 'Guest',
                  width: MediaQuery.of(context).size.height * 0.5,
                  onPressed: () {},
                  colors: [
                    AppColor.hidenBlue,
                    AppColor.hidenBlue,
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
