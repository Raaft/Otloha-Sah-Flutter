import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/google_facebook.dart';
import 'package:flutter_base/core/widgets/password_form_field.dart';
import 'package:flutter_base/core/widgets/text_from_fielid.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/';

  LoginPage({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.backGroundImage,
            fit: BoxFit.fitWidth,
            //height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            height: 100,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue,
                  size: 19,
                )),
          ),
          loginComponents(context)
        ],
      ),
    );
  }

  Widget loginComponents(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextView(
            text: tr('Log-in'),
            sizeText: 40,
            weightText: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormFieldApp(
                      controller: emailController,
                      keyType: TextInputType.emailAddress,
                      title: 'Email',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your email address';
                        }
                      },
                      onSaved: (value) {}),
                  PasswordFormField(
                    controller: passwordController,
                    title: 'Password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your email address';
                      }
                    },
                    onSaved: (val) {},
                  ),
                  TextView(
                    text: tr('ForgotPassword') + ' ?',
                    sizeText: 13,
                    action: () {},
                    weightText: FontWeight.w500,
                    textAlign: TextAlign.end,
                    colorText: AppColor.silver,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.blue,
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        tr('Login'),
                      ),
                      onPressed: () {},
                    ),
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
                        action: () {},
                        weightText: FontWeight.w500,
                        textAlign: TextAlign.end,
                        colorText: AppColor.darkSilver,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  const Expanded(
                      child: Divider(
                    thickness: 2,
                    color: Colors.black,
                  )),
                  TextView(
                    text: tr('loginwith'),
                    sizeText: 13,
                    action: () {},
                    weightText: FontWeight.w500,
                    textAlign: TextAlign.end,
                    colorText: AppColor.black87,
                  ),
                  const Expanded(
                      child: Divider(
                    thickness: 2,
                    color: Colors.black,
                  )),
                ],
              ),
              const GoogleAndFacebook(),
            ],
          ),
          TextView(
            text: tr('Need help'),
            sizeText: 13,
            action: () {},
            weightText: FontWeight.w500,
            textAlign: TextAlign.end,
            colorText: AppColor.silver,
          ),
        ],
      ),
    );
  }
}
