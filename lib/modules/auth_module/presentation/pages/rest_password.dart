import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/page_layout.dart';
import 'package:sms_autofill/sms_autofill.dart';

class RestPasswordPage extends StatelessWidget {
  const RestPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageLayout(context, restPasswordComponents(context)),
    );
  }
}

Widget restPasswordComponents(context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    alignment: Alignment.center,
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PinFieldAutoFill(
          codeLength: 4,
          onCodeChanged: (val) {
            print(val);
          },
        ),
<<<<<<< HEAD
        AuthButton(
            buttonText: 'Submit',
            width: MediaQuery.of(context).size.width * .5,
            onPressed: () {},
            colors: [AppColor.darkBlue, AppColor.lightBlue])
=======
        AuthButton(buttonText: 'Submit', width: MediaQuery.of(context).size.width*.5, onPressed: (){}, colors: [AppColor.darkBlue,AppColor.lightBlue])
>>>>>>> 2b6e9ade6a45c2c1f7ca2e7069885e648350bae9
      ],
    ),
  );
}
