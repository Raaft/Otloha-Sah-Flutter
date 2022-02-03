import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/google_facebook.dart';
import 'package:flutter_base/core/widgets/password_form_field.dart';
import 'package:flutter_base/core/widgets/text_from_fielid.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

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
            fit: BoxFit.cover,
          //  height: MediaQuery.of(context).size.height,
          ),
          loginComponents(context)
        ],
      ),
    );
  }

  Widget loginComponents(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blue,
                  )),
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
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormFieldApp(
                          controller: emailController,
                          keyType: TextInputType.emailAddress,
                          title: 'Email',
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
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
                        text: tr('ForgotPassword ?'),
                        sizeText: 13,
                        action: () {},
                        weightText: FontWeight.w500,
                        textAlign: TextAlign.end,
                        colorText: AppColor.black87,
                      ),
                      SizedBox(
                        width: double.infinity,
                        //height: 100.0,
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
                            tr('Log-in'),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Row(children: [
                        Text(tr('Registernow?'),style: const TextStyle(fontSize: 10),),
                        TextView(
                          text: tr('RegisterNow'),
                          sizeText: 13,
                          action: () {},
                          weightText: FontWeight.w500,
                          textAlign: TextAlign.end,
                          colorText: AppColor.black87,
                        ),

                      ],),
                      Row(children: [
                        const Expanded(child: Divider(thickness: 2,color: Colors.black,)),
                        TextView(
                          text: tr('loginwith'),
                          sizeText: 13,
                          action: () {},
                          weightText: FontWeight.w500,
                          textAlign: TextAlign.end,
                          colorText: AppColor.black87,
                        ),

                        const Expanded(child: Divider(thickness: 2,color: Colors.black,)),
                      ],),
                      const GoogleAndFacebook()
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
