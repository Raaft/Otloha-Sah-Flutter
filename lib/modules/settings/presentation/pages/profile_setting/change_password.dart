import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../auth_module/presentation/widget/auth_button.dart';

import '../../../../../../core/utils/constant/utils.dart';
import '../../../../../../core/utils/themes/color.dart';
import '../../../../../../core/widgets/tool_bar_app.dart';
import '../../../../../core/widgets/text_from_fielid.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shrinkWrap: true,
          children: [
            topView(context),
            const SizedBox(height: 200),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  customFormField(
                      controller: oldPasswordController,
                      title: tr('Old Password'),
                      keyboardType: TextInputType.visiblePassword,
                      validator: [
                        FormBuilderValidators.required(context),
                      ]),
                  const SizedBox(height: 20),
                  customFormField(
                      controller: newPasswordController,
                      title: tr('New Password'),
                      validator: [
                        FormBuilderValidators.required(context),
                      ],
                      keyboardType: TextInputType.visiblePassword),
                  const SizedBox(height: 20),
                  customFormField(
                      controller: confirmPasswordController,
                      title: tr('Confirm Password'),
                      validator: [
                        FormBuilderValidators.required(context),
                      ],
                      keyboardType: TextInputType.visiblePassword),
                  AuthButton(
                    buttonText: tr('Update'),
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
            )
          ],
        ),
      ),
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
      title: translate('Change Password'),
    );
  }
}
