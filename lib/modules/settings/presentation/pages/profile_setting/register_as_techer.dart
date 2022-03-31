// ignore_for_file: prefer_single_quotes

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/modules/settings/business_logic/settings/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as _get;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

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
  PlatformFile? cv;
  PlatformFile? recitation;
  PlatformFile? certifications;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (ctx, state) {
        if (state is RegisterAsTeacherSuccessState) {
          _get.Get.back();
          _get.Get.showSnackbar(const _get.GetSnackBar(
            duration: Duration(seconds: 3),
            message: 'Your request to be a teacher is created successfully',

          ),

          );
        }
      },
      builder: (ctx, state) {
        var cubit = SettingsCubit.get(context);

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
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
                          title: tr('Your Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return tr('please enter your email address');
                            }
                            return null;
                          },
                        ),
                        TextFormFieldApp(
                          color: AppColor.lightBlue,
                          controller: educationController,
                          keyType: TextInputType.emailAddress,
                          title: tr('Your Education'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email Education';
                            }
                            return null;
                          },
                        ),
                        buildFormBuilderFilePicker(
                          title: tr('Upload Your Cv'),
                          function: (val) {
                            setState(() {
                              cv = val![0];
                            });
                            print('file ${val![0].path}');
                          },
                        ),
                        const SizedBox(height: 10),
                        buildFormBuilderFilePicker(
                          title: tr('Selected Recitation'),
                          function: (val) {
                            setState(() {
                              recitation = val![0];
                            });
                            print('file ${val![0].path}');
                          },
                        ),
                        const SizedBox(height: 10),
                        buildFormBuilderFilePicker(
                          title: tr('Certifications'),
                          function: (val) {
                            setState(() {
                              certifications = val![0];
                            });
                            print('file ${val![0].path}');
                          },
                        ),
                        if (state is UpdateEmailLoadingState)
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        else
                          AuthButton(
                            buttonText: tr('Update'),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                debugPrint('validate');
                                var formData = FormData.fromMap({
                                  "full_name": nameController.text,
                                  "education_degree": educationController.text,
                                  "application_recitation":
                                      MultipartFile.fromFile(recitation!.path!,
                                          filename: recitation!.path
                                              ?.split('/')
                                              .last),
                                  "cv": MultipartFile.fromFile(cv!.path!,
                                      filename: cv!.path!.split('/').last),
                                  "certifications": MultipartFile.fromFile(
                                      certifications!.path!,
                                      filename: certifications!.path!
                                          .split('/')
                                          .last),
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
          ),
        );
      },
    );
  }

  buildFormBuilderFilePicker({
    required String title,
    required Function(List?) function,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilderFilePicker(
        name: "images",
        decoration: InputDecoration(
          //  color: Colors.blue,
          isDense: true,
          //  contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
          filled: true,
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border,
          focusedErrorBorder: border,
          disabledBorder: border,
          // labelStyle: style.copyWith(color: color),
          labelText: title,

          //hintStyle: style,
          // hintText: title,
          fillColor: AppColor.white,
        ),
        maxFiles: 1,
        previewImages: false,
        onChanged: function,
        selector: Row(
          children: const <Widget>[
            Icon(Icons.file_upload),
            Text('Upload'),
          ],
        ),
        onFileLoading: (val) {
          print('onFileLoading print $val');
        },
      ),
    );
  }

  //
  //  uploadfiles(
  //     {required SettingsCubit cubit,
  //     required String title,
  //     required Function function}) {
  //   return InkWell(
  //     onTap: function(),
  //     child: FormBuilderTextField(
  //         name: title,
  //         enabled: false,
  //         decoration: InputDecoration(
  //           isDense: true,
  //           fillColor: Colors.blue.withOpacity(.0),
  //           filled: true,
  //           enabledBorder: border,
  //           focusedBorder: border,
  //           errorBorder: border,
  //           focusedErrorBorder: border,
  //           disabledBorder: border,
  //           labelStyle: TextStyle(color: AppColor.lightBlue),
  //           labelText: title,
  //         )),
  //   );
  // }
  //
  // formUpload({required String title, required Function fun}) {
  //   return FormBuilderFilePicker(
  //     name: "images",
  //
  //     decoration: InputDecoration(
  //       isDense: true,
  //       fillColor: Colors.blue.withOpacity(.0),
  //       filled: true,
  //       enabledBorder: border,
  //       focusedBorder: border,
  //       errorBorder: border,
  //       focusedErrorBorder: border,
  //       disabledBorder: border,
  //       labelStyle: TextStyle(color: AppColor.lightBlue),
  //       labelText: title,
  //     ),
  //
  //     //  decoration: InputDecoration(labelText: "Attachments"),
  //     maxFiles: null,
  //     previewImages: true,
  //
  //     // onChanged: (val) => print(val),
  //     selector: Row(
  //       children: const <Widget>[
  //         Icon(Icons.file_upload),
  //         Text('Upload'),
  //       ],
  //     ),
  //
  //     onSaved: fun(),
  //   );
  // }

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
