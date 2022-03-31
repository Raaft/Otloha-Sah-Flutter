import 'package:flutter/material.dart';

import '../../../../core/utils/themes/color.dart';

Widget roundedButton({required String title, required Function function,required Color color}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppColor.lightBlue,
       // onPrimary: Colors.white,
        onSurface: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(title),
      onPressed: () {},
    ),
  );
}