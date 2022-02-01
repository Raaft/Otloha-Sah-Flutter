import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final String title;
  final Function() action;
  Widget? icon;
  bool isFullWidth = false;
  Color? bcolor;
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
    this.bcolor,
    this.style = const TextStyle(fontSize: 20, color: Colors.white),
    this.radius = 12,
    this.borderColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bcolor = (bcolor == null) ? Theme.of(context).primaryColor : bcolor;
    borderColor =
        (borderColor == null) ? Theme.of(context).primaryColor : borderColor;

    padding = (padding != null)
        ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0)
        : padding;
    return Container(
      padding: padding,
      // width: isFullWidth ? MediaQuery.of(context).size.width : null,
      child: Center(
        child: FloatingActionButton.extended(
          backgroundColor: bcolor,
          label: Text(
            title,
            style: style,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: borderColor!),
          ),
          icon: icon,
          onPressed: action,
        ),
      ),
    );
  }
}
