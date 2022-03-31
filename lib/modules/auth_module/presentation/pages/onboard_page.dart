import 'package:flutter/material.dart';
import '../../../../core/utils/res/images_app.dart';
import '../../../../core/utils/themes/color.dart';
import '../../business_logic/auth_cubit.dart';
import 'login_page.dart';
import 'sign_up.dart';
import '../widget/auth_button.dart';
import '../widget/back_button.dart';
import '../widget/background_image.dart';
import '../../../home/presentation/pages/home/home_page.dart';
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
