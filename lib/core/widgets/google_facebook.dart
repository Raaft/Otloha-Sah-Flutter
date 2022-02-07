import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/widgets/icon_button.dart';

class GoogleAndFacebook extends StatelessWidget {
  const GoogleAndFacebook({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButtonApp(
          bcolor: Colors.white,
          action: () {},
          icon: Image.asset(AppIcons.googleIcon),
        ),
        IconButtonApp(
          bcolor: Colors.blueAccent,
          action: () {},
          icon: const Icon(
            Icons.facebook,
            size: 34,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
