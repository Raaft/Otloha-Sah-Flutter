import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

Widget backButton() {
  return Positioned(
    height: 100,
    child: IconButton(
        onPressed: () {
          Get.back();
        },
        icon:  Icon(
          Icons.arrow_back_ios,
          color: AppColor.lightBlue,
          size: 19,
        )),
  );
}
