import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:get/get.dart';

class AlertDialogFullScreen extends StatelessWidget {
  const AlertDialogFullScreen({
    Key? key,
  }) : super(key: key);
  // final BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 1),
      Get.back,
    );
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * .3),
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.darkBlue,
              AppColor.lightBlue,
            ],
          ).createShader(
            Rect.fromLTRB(
              0,
              0,
              rect.width,
              rect.height,
            ),
          );
        },
        //  blendMode: BlendMode.dstIn,
        child: Flexible(
          child: Icon(
            Icons.library_add_check_outlined,
            color: AppColor.btnColor2,
            //colorBlendMode: BlendMode.lighten,
            size: MediaQuery.of(context).size.width * .4,
          ),
        ),
      ),
    );
  }
}
