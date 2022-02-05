import 'package:flutter/material.dart';

import 'back_button.dart';
import 'background_image.dart';

Widget pageLayout(BuildContext context, Widget pageComponents) {
  return SingleChildScrollView(
    child: Stack(
      children: [
        layoutBackgroundImage(),
        pageComponents,
        backButton(),
      ],
    ),
  );
}
