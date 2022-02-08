import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';

class ButtonApp extends StatelessWidget {
  final String title;
  final Function() action;
  final Widget? icon;
  final bool isFullWidth;
  final Color? bColor;
  final Color? borderColor;
  final TextStyle style;
  final double radius;
  final EdgeInsetsGeometry? padding;

  const ButtonApp({
    Key? key,
    required this.title,
    required this.action,
    this.icon,
    this.isFullWidth = false,
    this.bColor = AppColor.btnColor1,
    this.style = const TextStyle(fontSize: 20, color: Colors.white),
    this.radius = 12,
    this.borderColor = AppColor.btnColor1,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: padding,
        // width: isFullWidth ? MediaQuery.of(context).size.width : null,
        child: Center(
            child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
            onPrimary: Colors.white,
            onSurface: Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            textStyle:
                const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          onPressed: action,
          child: Text(tr('Log-in')),
        )));
  }
}
