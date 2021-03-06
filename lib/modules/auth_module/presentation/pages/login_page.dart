import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_from_fielid.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/core/widgets/vali_errorr_text.dart';
import 'package:flutter_base/modules/auth_module/business_logic/auth_cubit.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/rest_password.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/sign_up.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/need_help.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/page_head_text.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/page_layout.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';

import '../../../home/business_logic/cubit/profile_pic_cubit/profile_page_cubit.dart';
import '../../../home/presentation/pages/home/home_page.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/loginPage';

   LoginPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: BorderSide(width: 1, color: AppColor.lightBlue),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageLayout(context, loginComponents(context)),
    );
  }

  Widget loginComponents(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogInSuccessState) {
          var cubit = AuthCubit.get(context);
          cubit.changeIsLogin(islog: true).then((value) {
            cubit.saveProfile().then((value) {
              ProfilePageCubit.get(context).userProfile().then((value){
                Get.offAll(() => const HomePage());

              });
            });
          });
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(35),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                pageLayOutTextHead(tr('Log-in')),
                loginForm(cubit),
                /*     loginWith(
                  tr('loginwith'),
                ),    */
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
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  customFormField(
                    title: tr('Email'),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator:  [
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.email(context),
                    ]

                  ),
                  (state is LogInErrorState)
                      ? ValidationErrorText(
                          error: (state.error['email'] != null)
                              ? state.error['email'][0]
                              : '')
                      : const SizedBox(),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  customFormField(
                    title: tr('password'),
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: [                      FormBuilderValidators.required(context),
                    ]
                  ),
                  (state is LogInErrorState)
                      ? ValidationErrorText(
                          error: (state.error['password'] != null)
                              ? state.error['password'][0]
                              : '')
                      : const SizedBox(),
                ],
              ),
              (state is LogInErrorState)
                  ? ValidationErrorText(
                      error: (state.error['non_field_errors'] != null)
                          ? state.error['non_field_errors'][0]
                          : '')
                  : const SizedBox(),
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
                  return (state is LogInLoadingState)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            // var homeCubit = HomeCubit.get(context);
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
cubit.saveUsers();
                                       // CacheHelper.saveData(key: 'token',value:'token' );
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
                      Get.to(const SignUpPage());
                    },
                    weightText: FontWeight.w500,
                    textAlign: TextAlign.end,
                    colorText: AppColor.darkSilver,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
