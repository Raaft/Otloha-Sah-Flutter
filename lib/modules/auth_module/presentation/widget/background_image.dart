import 'package:flutter/material.dart';

Widget layoutBackgroundImage(String image) {
  return Image.asset(
    image,
    fit: BoxFit.fitWidth,
    //height: MediaQuery.of(context).size.height,
  );
}
