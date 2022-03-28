// ignore_for_file: prefer_single_quotes

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/modules/settings/business_logic/settings/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart'as _get;

import '../../../../../../core/utils/constant/utils.dart';
import '../../../../../../core/utils/themes/color.dart';
import '../../../../../../core/widgets/text_from_fielid.dart';
import '../../../../../../core/widgets/tool_bar_app.dart';
import '../../../../auth_module/presentation/widget/auth_button.dart';

class RegisterAsTeacher extends StatefulWidget {
  const RegisterAsTeacher({Key? key}) : super(key: key);

  @override
  State<RegisterAsTeacher> createState() => _RegisterAsTeacherState();
}

class _RegisterAsTeacherState extends State<RegisterAsTeacher> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController educationController = TextEditingController();
  File? cv;
  File? recitation;
  File? certifications;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (ctx, state) {
        if (state is   RegisterAsTeacherSuccessState ) {
          _get.Get.showSnackbar(const _get.GetSnackBar(duration:Duration(seconds: 3) ,
          message: 'Your request to be a teacher is created successfully',));
        }
      },
      builder: (ctx, state) {
        var cubit = SettingsCubit.get(context);

        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                topView(context),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormFieldApp(
                        color: AppColor.lightBlue,
                        controller: nameController,
                        keyType: TextInputType.emailAddress,
                        title: 'Your Name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                          return null;
                        },
                      ),
                      TextFormFieldApp(
                        color: AppColor.lightBlue,
                        controller: educationController,
                        keyType: TextInputType.emailAddress,
                        title: 'Your Education',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                          return null;
                        },
                      ),
                      AuthButton(
                          buttonText: 'Upload Your Cv',
                          width: MediaQuery.of(context).size.width / 3,
                          onPressed: () {
                            cubit.uploadFile()!.then((value) {
                              setState(() {
                                cv = value;
                              });
                            });
                          },
                          colors: [
                            AppColor.lightBlue,
                            AppColor.lightBlue,
                          ]),
                      AuthButton(
                          buttonText: 'Selected Recitation',
                          width: MediaQuery.of(context).size.width / 3,
                          onPressed: () {
                            cubit.uploadFile()!.then((value) {
                              setState(() {
                                recitation = value;
                              });
                            });
                          },
                          colors: [
                            AppColor.lightBlue,
                            AppColor.lightBlue,
                          ]),
                      AuthButton(
                          buttonText: 'Certifications',
                          width: MediaQuery.of(context).size.width / 3,
                          onPressed: () {
                            cubit.uploadFile()!.then((value) {
                              setState(() {
                                certifications = value;
                              });
                            });
                          },
                          colors: [
                            AppColor.lightBlue,
                            AppColor.lightBlue,
                          ]),
                      (state is UpdateEmailLoadingState)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : AuthButton(
                              buttonText: tr('Update'),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  debugPrint('validate');
                               var formData=   FormData.fromMap({
                                    "full_name": nameController.text,
                                    "education_degree": educationController.text,
                                    "application_recitation":
                                        MultipartFile.fromFile(recitation!.path,
                                            filename: recitation!.path
                                                .split('/')
                                                .last),
                                    "cv": MultipartFile.fromFile(cv!.path, filename: cv!.path.split('/').last),
                                    "certifications": MultipartFile.fromFile(certifications!.path, filename: certifications!.path.split('/').last),
                                  });

                                  cubit.regiAsTeacher(data: formData);
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
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget topView(BuildContext context) {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: translate('Register As Teacher'),
    );
  }
}
