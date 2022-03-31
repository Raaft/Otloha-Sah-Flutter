import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_from_fielid.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../../core/utils/constant/utils.dart';
import '../../../../../../core/widgets/tool_bar_app.dart';

class UpdatePhone extends StatelessWidget {
  UpdatePhone({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            topView(context),
            const SizedBox(
              height: 200,
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customFormField(
                      //  color: AppColor.lightBlue,
                      controller: emailController,
                      keyboardType: TextInputType.phone,
                      title: tr('New Phone'),
                      validator: [
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  customFormField(
                      controller: passwordController,
                      title: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      validator: [
                        FormBuilderValidators.required(context),
                      ]),
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
      title: translate('Update Phone'),
    );
  }
}
