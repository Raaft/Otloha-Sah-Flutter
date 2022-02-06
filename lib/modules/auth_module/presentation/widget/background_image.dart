import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';

Widget layoutBackgroundImage(String image) {
  return Image.asset(
    image,
    fit: BoxFit.fitWidth,
    //height: MediaQuery.of(context).size.height,
  );
}
