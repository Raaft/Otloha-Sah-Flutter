import 'package:flutter/material.dart';
import '../utils/res/icons_app.dart';

class GoogleAndFacebook extends StatelessWidget {
  const GoogleAndFacebook({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Image.asset(AppIcons.googleIcon),
          onPressed: () {},
        ),
        IconButton(
          icon: Image.asset(AppIcons.facebookIcon),
          onPressed: () {},
        ),
        IconButton(
          icon: Image.asset(AppIcons.twitterIcon),
          onPressed: () {},
        ),
      ],
    );
  }
}
