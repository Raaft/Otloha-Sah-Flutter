import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/password_form_field.dart';
import 'package:flutter_base/core/widgets/text_from_fielid.dart';
import 'package:flutter_base/modules/auth_module/business_logic/auth_cubit.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/login_with.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/need_help.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/page_head_text.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/page_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/data/chash_helper.dart';
import '../../../../core/utils/constant/constants.dart';
import '../../../home/business_logic/cubit/home_cubit.dart';
import '../../../home/presentation/pages/home/home_page.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = '/signUpPage';

  SignUpPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is LogInSuccessState) {
      Get.to(() => BlocProvider(
          create: (context) => HomeCubit(),
          child: const HomePage()));
      ;

    }  },
  builder: (context, state) {
    return pageLayout(context, signupComponents(context));
  },
),
      ),
    );
  }

  Widget signupComponents(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 35, right: 35, left: 35),
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pageLayOutTextHead(tr('Sign-up')),
            //  signUpForm(),
            const SignForm(),
            loginWith(
              tr('signupWith'),
            ),
            needHelpText(),
          ],
        ),
      ),
    );
  }

/*  Widget signUpForm() {
    return
  }
*/

}

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  DateTime currentDate = DateTime.now();

  List gender = [
    'Male',
    'Female',
  ];

  String select = 'male';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormFieldApp(
                color: AppColor.lightBlue,
                controller: userNameController,
                keyType: TextInputType.name,
                title: 'User Name',
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
                title: 'Email',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your Email';
                  }
                  return null;
                },
                onSaved: (value) {}),
            TextFormFieldApp(
                color: AppColor.lightBlue,
                controller: phoneController,
                keyType: TextInputType.phone,
                title: 'Mobile',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your Mobile';
                  }
                  return null;
                },
                onSaved: (value) {}),
           Row(
              children: <Widget>[
                addRadioButton(0, 'Male'),
                addRadioButton(1, 'Female'),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                  print(currentDate.toString());
                },
                child: const Text('Choice your birthDate')),
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
              controller: confirmPasswordController,
              title: 'Confirm Password',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please enter your Confirm Password';
                }
                return null;
              },
              onSaved: (val) {},
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LogInSuccessState) {
                  Get.to(() => BlocProvider(
                      create: (context) => HomeCubit(),
                      child: const HomePage()));
                }                },
              builder: (context, state) {
                var cubit = AuthCubit.get(context);
                return AuthButton(
                  buttonText: tr('sign Up'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      debugPrint('validate');
                      String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
                      cubit.userRegister(
                          email: emailController.text,
                          username: userNameController.text,
                          phone: phoneController.text,
                          password2: confirmPasswordController.text,
                          password1: passwordController.text,
                          gender: select.toLowerCase(),
                          birthdate:formattedDate


                      ) .then((value) {
                        token =  CacheHelper.getData(key: 'token')??'';
                        if (state is LogInSuccessState) {
                          Get.to(() => BlocProvider(
                              create: (context) => HomeCubit(),
                              child: const HomePage()));


                      }})
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
          ],
        ),
      ),
    );
  }

  addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio<String>(
          activeColor: AppColor.lightBlue,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value!;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(
            color: AppColor.lightBlue,
          ),
        )
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2030 - 01 - 01));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }
}
