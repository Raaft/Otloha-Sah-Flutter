import 'package:flutter/material.dart';

import '../utils/themes/color.dart';
import 'text_view.dart';

class ToolBarApp extends StatelessWidget {
  const ToolBarApp({
    Key? key,
    this.backIcon,
    this.actionIcon,
    required this.title,
  }) : super(key: key);

  final Widget? backIcon;
  final Widget? actionIcon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          backIcon ?? Container(),
          Expanded(
            child: TextView(
              text: title,
              colorText: AppColor.txtColor3,
              weightText: FontWeight.bold,
            ),
          ),
          actionIcon ?? Container(),
        ],
      ),
    );
  }
}
