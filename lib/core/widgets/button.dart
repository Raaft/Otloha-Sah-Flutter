import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final String title;
  final Function() action;
  Widget? icon;
  bool isFullWidth = false;
  Color? bColor;
  Color? borderColor;
  TextStyle style;
  final double radius;
  EdgeInsetsGeometry? padding;

  ButtonApp({
    Key? key,
    required this.title,
    required this.action,
    this.icon,
    this.isFullWidth = false,
    this.bColor,
    this.style = const TextStyle(fontSize: 20, color: Colors.white),
    this.radius = 12,
    this.borderColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bColor = (bColor == null) ? Theme.of(context).primaryColor : bColor;
    borderColor =
        (borderColor == null) ? Theme.of(context).primaryColor : borderColor;

    padding = (padding != null)
        ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0)
        : padding;
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
