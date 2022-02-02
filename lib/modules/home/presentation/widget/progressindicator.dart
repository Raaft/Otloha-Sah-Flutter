import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

class ProgressIndicatorApp extends StatelessWidget {
  const ProgressIndicatorApp({
    Key? key,
    required this.name,
    required this.type,
    required this.value,
  }) : super(key: key);

  final String name;
  final String type;
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            padding: const EdgeInsets.all(2),
            text: name,
            sizeText: 12,
            colorText: AppColor.txtColor3,
            weightText: FontWeight.bold,
            textAlign: TextAlign.start,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                padding: const EdgeInsets.all(2),
                text: type,
                sizeText: 12,
                colorText: AppColor.txtColor3,
                textAlign: TextAlign.start,
              ),
              TextView(
                padding: const EdgeInsets.all(2),
                text: '${(value * 100).round()}%',
                sizeText: 10,
                textAlign: TextAlign.start,
                colorText: AppColor.proogTxtColor1,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 8,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
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
