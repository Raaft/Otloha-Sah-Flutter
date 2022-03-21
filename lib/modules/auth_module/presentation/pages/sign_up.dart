import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/password_form_field.dart';
import 'package:flutter_base/core/widgets/text_from_fielid.dart';
import 'package:flutter_base/core/widgets/valdate_error.dart';
import 'package:flutter_base/modules/auth_module/business_logic/auth_cubit.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/need_help.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/page_head_text.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/page_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/data/chash_helper.dart';
import '../../../../core/utils/constant/constants.dart';
import '../../../home/presentation/pages/home/home_page.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = '/signUpPage';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            var cubit = AuthCubit.get(context);
            cubit.changeIsLogin(isLog: true).then((value) {
              Get.to(() => const HomePage());
            } );
          },
          builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return pageLayout(context, signupComponents(context, cubit));
          },
        ),
      ),
    );
  }

  Widget signupComponents(BuildContext context, AuthCubit cubit) {
    return Container(
      padding: const EdgeInsets.only(top: 35, right: 35, left: 35),
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pageLayOutTextHead(tr('Sign-up')),
            //  signUpForm(),
            SignForm(
              cubit: cubit,
            ),
            /* loginWith(
              tr('signupWith'),
            ), */
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
  const SignForm({Key? key, required this.cubit}) : super(key: key);
  final AuthCubit cubit;

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
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FieldValidation(
                  error: (state is RegisterErrorState)
                      ? state.error['username']
                      :[''],
                  textField: TextFormFieldApp(
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
                      ),
                ),
                FieldValidation(
                  error:
                      (state is RegisterErrorState) ? state.error['email'] : [],
                  textField: TextFormFieldApp(
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
                      ),
                ),
                FieldValidation(
                  error:
                      (state is RegisterErrorState) ? state.error['phone'] : [],
                  textField: TextFormFieldApp(
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
                     ),
                ),
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
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  return (state is LogInLoadingState)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : AuthButton(
                          buttonText: tr('sign Up'),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              debugPrint('validate');
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(currentDate);
                              widget.cubit
                                  .userRegister(
                                      email: emailController.text,
                                      username: userNameController.text,
                                      phone: phoneController.text,
                                      password2: confirmPasswordController.text,
                                      password1: passwordController.text,
                                      gender: select.toLowerCase(),
                                      birthdate: formattedDate)
                                  .then((value) {
                                token = CacheHelper.getData(key: 'token') ?? '';
                                formKey.currentState!.reset();
                              }).catchError((e) {
                                print('ERROR IN LOG IN IS $e');
                              });
                            } else if (state is RegisterErrorState) {
                              return state.error;
                            }
                          },
                          width: double.infinity,
                          colors: [
                            AppColor.darkBlue,
                            AppColor.lightBlue,
                          ],
                        );
                })
              ],
            );
          },
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
