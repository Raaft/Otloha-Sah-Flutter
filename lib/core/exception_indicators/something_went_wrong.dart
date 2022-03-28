import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';

class SomethingWentWrongWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Something went wrong'));
  }
}
class ServerErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Center(child:  Column(
      children: [
        Image.asset(AppIcons.emptyIcon),
        const Text('Server Error')
      ],
    ));
  }
}
