import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/utils/themes/text_style.dart';

class TextView extends StatelessWidget {
  const TextView(
      {Key? key,
      required this.text,
      this.textAlign = TextAlign.center,
      this.action,
      this.padding = const EdgeInsets.all(4),
      this.icon,
      this.colorText,
      this.sizeText,
      this.weightText,
      this.fontFamily = fontFamily2,
      this.overflow = TextOverflow.clip})
      : super(key: key);

  final String text;
  final String fontFamily;
  final TextAlign textAlign;
  final Function()? action;
  final EdgeInsetsGeometry padding;
  final Icon? icon;
  final Color? colorText;
  final double? sizeText;
  final FontWeight? weightText;

  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: AppStyle().textStyle1.copyWith(
              fontSize: sizeText,
              color: colorText,
              fontWeight: weightText,
              wordSpacing: .5,
              fontFamily: fontFamily),
          textAlign: textAlign,
          overflow: overflow,
        ),
      ),
    );
  }
}

class TextViewIcon extends StatelessWidget {
  const TextViewIcon({
    Key? key,
    required this.text,
    this.action,
    this.textAlign,
    this.padding = const EdgeInsets.all(8),
    this.icon,
    this.colorText,
    this.sizeText,
    this.weightText,
  }) : super(key: key);

  final String text;
  final TextAlign? textAlign;
  final Function()? action;
  final EdgeInsetsGeometry padding;
  final Widget? icon;
  final Color? colorText;
  final double? sizeText;
  final FontWeight? weightText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: (textAlign == TextAlign.center)
              ? MainAxisAlignment.center
              : (textAlign == TextAlign.start)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
          children: [
            if (icon != null) icon!,
            if (icon != null) const SizedBox(width: 8),
            Text(
              text,
              style: AppStyle().textStyle1.copyWith(
                    fontSize: sizeText,
                    color: colorText,
                    fontWeight: weightText,
                  ),
              textAlign: textAlign,
            ),
          ],
        ),
      ),
    );
  }
}
