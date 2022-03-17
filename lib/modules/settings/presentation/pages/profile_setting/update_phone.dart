import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';

import '../../../../../../core/utils/constant/utils.dart';
import '../../../../../../core/utils/themes/color.dart';
import '../../../../../../core/widgets/password_form_field.dart';
import '../../../../../../core/widgets/text_from_fielid.dart';
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
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shrinkWrap: true,
          children: [
            topView(context),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormFieldApp(
                      color: AppColor.lightBlue,
                      controller: emailController,
                      keyType: TextInputType.phone,
                      title: 'New Phone',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your email address';
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
