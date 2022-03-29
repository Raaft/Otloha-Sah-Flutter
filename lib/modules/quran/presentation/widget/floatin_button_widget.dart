import 'package:flutter/material.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../home/business_logic/cubit/home_cubit.dart';
import '../../business_logic/cubit/quran_cubit.dart';

Widget floatingButton(
    {required QuranViewCubit cubit,
    HomeCubit? homeCubit,
    required bool isPressed}) {
  if (isPressed) {
    cubit.changeOpacity(1);
  } else {
    cubit.changeOpacity(.4);
  }

  return Positioned(
    bottom: 50,
    right: 20,
    child: Opacity(
      opacity: cubit.opacity,
      child: GestureDetector(
        onTap: () async {
          cubit.changeTrueFloating();
          homeCubit!.changeTrueFloating();
          cubit.changeOpacity(.0);
        },
        child: ball(),
      ),
    ),
  );
}

ball() {
  return CircleAvatar(
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
  );
}
