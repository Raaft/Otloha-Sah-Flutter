import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

Widget needHelpText() {
  return TextView(
    text: tr('Need help'),
    sizeText: 13,
    action: () {},
    weightText: FontWeight.w500,
    textAlign: TextAlign.center,
    colorText: AppColor.silver,
  );
}
