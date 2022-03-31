import 'package:flutter/material.dart';
import '../../../../core/utils/res/images_app.dart';

import 'back_button.dart';
import 'background_image.dart';

Widget pageLayout(BuildContext context, Widget pageComponents) {
  return Stack(
    children: [
      layoutBackgroundImage(AppImages.backGroundImage),
      pageComponents,
      backButton(),
    ],
  );
}
