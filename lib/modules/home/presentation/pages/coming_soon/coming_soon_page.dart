import 'package:flutter/material.dart';
import '../../../../../core/utils/res/icons_app.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({Key? key}) : super(key: key);

  static const routeName = '/comming_soon';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppIcons.comingSoonIcon,
          width: MediaQuery.of(context).size.width * .5,
        ),
      ),
    );
  }
}
