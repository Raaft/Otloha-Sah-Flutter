import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/auth_module/business_logic/auth_cubit.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/sign_up.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/back_button.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/background_image.dart';
import 'package:flutter_base/modules/home/presentation/pages/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.6),
                  AuthButton(
                    buttonText: 'Login',
                    width: MediaQuery.of(context).size.height * 0.5,
                    onPressed: () {
                      Get.to(() => LoginPage());
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
                      Get.to(() => const SignUpPage());
                    },
                    colors: [
                      AppColor.darkBlue,
                      AppColor.lightBlue,
                    ],
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          var cubit = AuthCubit.get(context);
                          return AuthButton(
                            buttonText: 'Guest',
                            width: MediaQuery.of(context).size.height * 0.5,
                            onPressed: () {
                              cubit.changeIsLogin(islog: false).then((value) {
                                Get.offAll(() => const HomePage());
                              });
                            },
                            colors: [
                              AppColor.hidenBlue,
                              AppColor.hidenBlue,
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          backButton()
        ],
      ),
    );
  }
}
