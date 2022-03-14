import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/password_form_field.dart';
import 'package:flutter_base/core/widgets/text_from_fielid.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/auth_module/business_logic/auth_cubit.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/rest_password.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/sign_up.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/login_with.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/need_help.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/page_head_text.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/page_layout.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import '../../../home/presentation/pages/home/home_page.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/loginPage';

  LoginPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: pageLayout(context, loginComponents(context)),
      ),
    );
  }

  Widget loginComponents(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogInSuccessState) {
          Get.to(() => BlocProvider(
              create: (context) => HomeCubit(),
              child: const HomePage()));
        }      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(35),
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                pageLayOutTextHead(tr('Log-in')),
                loginForm(cubit),
                loginWith(
                  tr('loginwith'),
                ),
                needHelpText(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget loginForm(AuthCubit cubit) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormFieldApp(
              color: AppColor.lightBlue,
              controller: emailController,
              keyType: TextInputType.emailAddress,
              title: 'Email',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please enter your email address';
                }
                return null;
              },
              onSaved: (value) {}),
          PasswordFormField(
            controller: passwordController,
            title: 'Password',
            validator: (value) {
              if (value!.isEmpty) {
                return 'please enter your email address';
              }
              return null;
            },
            onSaved: (val) {},
          ),
          TextView(
            text: tr('ForgotPassword') + ' ?',
            sizeText: 13,
            action: () {
              Get.to(PinPutTest());
            },
            weightText: FontWeight.w500,
            textAlign: TextAlign.end,
            colorText: AppColor.silver,
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return AuthButton(
                buttonText: tr('Login'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    debugPrint('validate');
                    cubit
                        .userLogIn(
                        email: emailController.text,
                        password: passwordController.text)
                        .then((value) {

                    })
                        .catchError((e) {
                      print('ERROR IN LOG IN IS $e');
                    });
                  }
                },
                width: double.infinity,
                colors: [
                  AppColor.darkBlue,
                  AppColor.lightBlue,
                ],
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr('Registernow?'),
                style: TextStyle(fontSize: 13, color: AppColor.silver),
              ),
              TextView(
                text: tr('RegisterNow'),
                sizeText: 15,
                action: () {
                  Get.to(SignUpPage());
                },
                weightText: FontWeight.w500,
                textAlign: TextAlign.end,
                colorText: AppColor.darkSilver,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
