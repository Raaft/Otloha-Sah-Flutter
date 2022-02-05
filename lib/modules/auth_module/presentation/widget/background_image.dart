import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';

Widget layoutBackgroundImage() {
  return Image.asset(
    AppImages.backGroundImage,
    fit: BoxFit.fitWidth,
    //height: MediaQuery.of(context).size.height,
  );
}
