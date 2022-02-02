import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/text_style.dart';

class TextView extends StatelessWidget {
  TextView({
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
  Function()? action;
  final EdgeInsetsGeometry padding;
  Icon? icon;
  Color? colorText;
  double? sizeText;
  FontWeight? weightText;

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
