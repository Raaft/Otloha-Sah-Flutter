import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';

class ProfileBNBPage extends StatelessWidget {
  const ProfileBNBPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppIcons.comingSoonIcon,
        width: MediaQuery.of(context).size.width * .5,
      ),
    );
  }
}
