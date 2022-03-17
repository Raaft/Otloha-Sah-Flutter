import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/modules/settings/business_logic/settings/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/constant/utils.dart';
import '../../../../../../core/utils/themes/color.dart';
import '../../../../../../core/widgets/password_form_field.dart';
import '../../../../../../core/widgets/text_from_fielid.dart';
import '../../../../../../core/widgets/tool_bar_app.dart';
import '../../../../auth_module/presentation/widget/auth_button.dart';


class UpdateEmail extends StatelessWidget {
  UpdateEmail({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (ctx, state) {
        // TODO: implement listener

      },
      builder: (ctx, state) {
        var cubit=SettingsCubit.get(context);

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
                          keyType: TextInputType.emailAddress,
                          title: 'New Email',
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
                      (state is UpdateEmailLoadingState)?const Center( child: CircularProgressIndicator(),):
                      AuthButton(
                        buttonText: tr('Update'),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            debugPrint('validate');
                            cubit.updateEmail(email: emailController.text, password: passwordController.text);
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
      title: translate('Update Email'),
    );
  }
}
