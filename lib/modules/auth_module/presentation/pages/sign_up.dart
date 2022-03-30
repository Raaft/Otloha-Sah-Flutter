import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_from_fielid.dart';
import 'package:flutter_base/modules/auth_module/business_logic/auth_cubit.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/need_help.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/page_head_text.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/page_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/vali_errorr_text.dart';
import '../../../../data_source/cache_helper.dart';
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

            if (state is RegisterSuccessState) {
              cubit.changeIsLogin(islog: true).then((value) {

                cubit.saveProfile().then((value) {
                  Get.offAll(() => const HomePage());
                });
              });
            }
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
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  DateTime currentDate = DateTime.now();
  var border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: BorderSide(width: 1, color: AppColor.lightBlue),
  );

  List gender = [
    'Male',
    'Female',
  ];

  String select = 'male';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: formKey,
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    customFormField(
                      // color: AppColor.lightBlue,
                      controller: userNameController,
                      keyboardType: TextInputType.name,
                      title: tr('User Name'),
                      validator:[ FormBuilderValidators.required(context),
                        ]
                    ),
                    (state is RegisterErrorState)
                        ? ValidationErrorText(
                            error: (state.error['username'] != null)
                                ? state.error['username'][0]
                                : '')
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(height: 20),

                Column(
                  children: [
                    customFormField(
                        title: tr('Email'),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: [
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.email(context),
                        ]),
                    (state is RegisterErrorState)
                        ? ValidationErrorText(
                            error: (state.error['email'] != null)
                                ? state.error['email'][0]
                                : '')
                        : const SizedBox(),
                  ],
                ),

                // FieldValidation(
                //   error: (state is RegisterErrorState)
                //       ? state.error['email'] ?? ['']
                //       : [''],
                //   textField: customFormField(
                //     //color: AppColor.lightBlue,
                //     controller: emailController,
                //     keyboardType: TextInputType.emailAddress,
                //     title: 'Email',
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'please enter your Email';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                const SizedBox(height: 20),

                Column(
                  children: [
                    customFormField(
                      title: tr('EnterYourphone'),
                      controller: phoneController,
                      keyboardType: TextInputType.emailAddress,
                      validator: [FormBuilderValidators.required(context)]
                    ),
                    (state is RegisterErrorState)
                        ? ValidationErrorText(
                            error: (state.error['phone'] != null)
                                ? state.error['phone'][0]
                                : '')
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(height: 20),

                // FieldValidation(
                //   error: (state is RegisterErrorState)
                //       ? state.error['phone'] ?? ['']
                //       : [''],
                //   textField: customFormField(
                //     //   color: AppColor.lightBlue,
                //     controller: phoneController,
                //     keyboardType: TextInputType.phone,
                //     title: 'Mobile',
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'please enter your Mobile';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                Column(
                  children: [
                    selectGender(),
                    (state is RegisterErrorState)
                        ? ValidationErrorText(
                        error: (state.error['gender'] != null)
                            ? state.error['gender'][0]
                            : '')
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(height: 20),

                Column(
                  children: [
                    FormBuilderDateTimePicker(
                      // attribute: “date”,
                      inputType: InputType.date,
                      format: DateFormat('dd-MM-yyyy'),

                      decoration: InputDecoration(
                        labelText: tr('Date of Birth'),
                        labelStyle: TextStyle(color: AppColor.lightBlue),
                        //color: Colors.blue,
                        isDense: true,
                        enabledBorder: border,
                        focusedBorder: border,
                        errorBorder: border,
                        focusedErrorBorder: border,
                        disabledBorder: border,

                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.lightBlue,
                            width: 10,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        //filled: true,
                      ),

                      // validator: [FormBuilderValidators.required()],
                      name: 'date',
                      onChanged: (value) {
                        setState(() {
                          currentDate = value!;
                        });
                      },
                    ),
                    (state is RegisterErrorState)
                        ? ValidationErrorText(
                        error: (state.error['birthdate'] != null)
                            ? state.error['birthdate'][0]
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
                      keyboardType: TextInputType.emailAddress,
                      validator:[                          FormBuilderValidators.required(context),
                      ]
                    ),
                    (state is RegisterErrorState)
                        ? ValidationErrorText(
                            error: (state.error['password1'] != null)
                                ? state.error['password1'][0]
                                : '')
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(height: 20),

                Column(
                  children: [
                    customFormField(
                      title: tr('EnterConfirmPassword'),
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.emailAddress,
                      validator:[                          FormBuilderValidators.required(context),
                      ]
                    ),
                    (state is RegisterErrorState)
                        ? ValidationErrorText(
                            error: (state.error['password2'] != null)
                                ? state.error['password2'][0]
                                : '')
                        : const SizedBox(),
                  ],
                ),

                // FieldValidation(
                //   error: (state is RegisterErrorState)
                //       ? state.error['password2'] ?? ['']
                //       : [''],
                //   textField: customFormField(
                //     keyboardType: TextInputType.visiblePassword,
                //     controller: confirmPasswordController,
                //     title: 'Confirm Password',
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'please enter your Confirm Password';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  return (state is LogInLoadingState)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : AuthButton(
                          buttonText: tr('RegisterNow'),
                          onPressed: () {
                           // formKey.currentState!.save();
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
                                token =  CacheHelper.getData(key: 'token') ?? '';
                                widget.   cubit.changeIsLogin(islog: true).then((value) {

                                  widget.     cubit.saveProfile().then((value) {
                                    Get.offAll(() => const HomePage());
                                  });
                                });


                                //  widget.cubit.changeIsLogin();
                               //formKey.currentState!.reset();
                              }).catchError((e) {
                                print('ERROR IN LOG IN IS $e');
                              });
                            } else if (state is RegisterErrorState) {
                              return state.error;
                            }else {
                              print('validation failed');
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

  FormBuilderDropdown<String> selectGender() {
    return FormBuilderDropdown(
      validator: FormBuilderValidators.compose(
          [FormBuilderValidators.required(context)]),
      decoration: InputDecoration(
        labelText: tr('Gender'),
        labelStyle: TextStyle(color: AppColor.lightBlue),
        //color: Colors.blue,
        isDense: true,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        focusedErrorBorder: border,
        disabledBorder: border,

        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.lightBlue,
            width: 10,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        //filled: true,
      ),
      hint: Text(
       tr( 'Select Gender'),
        style: TextStyle(color: AppColor.lightBlue),
      ),
      items: ['Male', 'Female']
          .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
          .toList(),
      name: 'gender',
      onChanged: (value) {
        setState(() {
          select = value!;
        });
      },
    );
  }

  // addRadioButton(int btnValue, String title) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Radio<String>(
  //         activeColor: AppColor.lightBlue,
  //         value: gender[btnValue],
  //         groupValue: select,
  //         onChanged: (value) {
  //           setState(() {
  //             print(value);
  //             select = value!;
  //           });
  //         },
  //       ),
  //       Text(
  //         title,
  //         style: TextStyle(
  //           color: AppColor.lightBlue,
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //       context: context,
  //       initialDate: currentDate,
  //       firstDate: DateTime(1900),
  //       lastDate: DateTime(2030 - 01 - 01));
  //   if (pickedDate != null && pickedDate != currentDate) {
  //     setState(() {
  //       currentDate = pickedDate;
  //     });
  //   }
  // }
}
