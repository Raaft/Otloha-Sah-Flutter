import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

Widget pageLayOutTextHead(String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 50, bottom: 50),
    child: TextView(
      text: title,
      sizeText: 40,
      weightText: FontWeight.bold,
      textAlign: TextAlign.center,
      colorText: AppColor.headTextColor,
    ),
  );
}
