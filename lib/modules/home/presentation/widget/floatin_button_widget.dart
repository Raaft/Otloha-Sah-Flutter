import 'package:flutter/material.dart';

import '../../../../core/utils/themes/color.dart';
import '../../business_logic/cubit/home_cubit.dart';

Widget floatingButton({required HomeCubit cubit, required bool isPressed}) {
  if (isPressed) {
    cubit.changeOpacity(1);
  } else {
    cubit.changeOpacity(.4);
  }

  return Positioned(
    bottom: 50,
    right: 20,
    child: Opacity(
      ///opacity: (isBressed)?1:.4,
      opacity: cubit.opacity,
      child: GestureDetector(
        onTap: () async {

          cubit.changeTrueFloating();
          cubit.changeOpacity(.0);

          
        },
        ///////////commit proplem
        child: CircleAvatar(
          radius: 30,
          backgroundColor: AppColor.darkBlue,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: AppColor.lightBlue,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColor.darkBlue,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColor.lightBlue,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColor.darkBlue,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
