import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/google_facebook.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

Widget loginWith(String type) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
              child: Divider(
                thickness: 1,
                color: AppColor.darkSilver,
              )),
          TextView(
            text: type,
            sizeText: 18,
            action: () {},
            weightText: FontWeight.w500,
            textAlign: TextAlign.end,
            colorText: AppColor.darkSilver,
          ),
          Expanded(
              child: Divider(
                thickness: 1,
                color: AppColor.darkSilver,
              )),
        ],
      ),
      const GoogleAndFacebook(),
    ],
  );
}
