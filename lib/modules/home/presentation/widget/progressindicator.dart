import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

class UserProgressIndicator extends StatelessWidget {
  const UserProgressIndicator({
    Key? key,
    required this.name,
    required this.type,
    required this.value,
    this.fontSize = 14,
    this.width,
  }) : super(key: key);

  final String name;
  final String type;
  final double value;
  final double fontSize;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * .25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            padding: const EdgeInsets.all(1),
            text: name,
            sizeText: fontSize,
            colorText: AppColor.txtColor3,
            weightText: FontWeight.bold,
            textAlign: TextAlign.start,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                padding: const EdgeInsets.all(1),
                text: type,
                sizeText: fontSize,
                colorText: AppColor.txtColor3,
                textAlign: TextAlign.start,
              ),
              TextView(
                padding: const EdgeInsets.all(1),
                text: '${(value * 100).round()}%',
                sizeText: fontSize - 4,
                textAlign: TextAlign.start,
                colorText: AppColor.proogTxtColor1,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(2)),
                child: LinearProgressIndicator(
                  value: value,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColor.proogessColor1),
                  backgroundColor: AppColor.proogessColor2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
