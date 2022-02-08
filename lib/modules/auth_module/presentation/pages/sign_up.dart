import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/password_form_field.dart';
import 'package:flutter_base/core/widgets/text_from_fielid.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/login_with.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/need_help.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/page_head_text.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/page_layout.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = '/signUpPage';

  SignUpPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: pageLayout(context, signupComponents(context))),
    );
  }

  Widget signupComponents(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 35, right: 35, left: 35),
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pageLayOutTextHead(tr('Sign-up')),
            signUpForm(),
            loginWith(
              tr('signupWith'),
            ),
            needHelpText(),
          ],
        ),
      ),
    );
  }

  Widget signUpForm() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldApp(
                color: AppColor.lightBlue,
                controller: emailController,
                keyType: TextInputType.emailAddress,
                title: 'Full Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your Full Name';
                  }
                  return null;
                },
                onSaved: (value) {}),
            TextFormFieldApp(
                color: AppColor.lightBlue,
                controller: emailController,
                keyType: TextInputType.emailAddress,
                title: 'User Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your User Name';
                  }
                  return null;
                },
                onSaved: (value) {}),
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
            TextFormFieldApp(
                color: AppColor.lightBlue,
                controller: emailController,
                keyType: TextInputType.emailAddress,
                title: 'Mobile',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your Mobile';
                  }
                  return null;
                },
                onSaved: (value) {}),
            PasswordFormField(
              controller: passwordController,
              title: 'Password',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please enter your Password';
                }
                return null;
              },
              onSaved: (val) {},
            ),
            PasswordFormField(
              controller: passwordController,
              title: 'Confirm Password',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please enter your Confirm Password';
                }
                return null;
              },
              onSaved: (val) {},
            ),
            AuthButton(
              buttonText: tr('Login'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  debugPrint('validate');
                }
              },
              width: double.infinity,
              colors: [
                AppColor.darkBlue,
                AppColor.lightBlue,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
