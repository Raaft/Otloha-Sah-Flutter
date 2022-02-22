import 'package:flutter/material.dart';

import '../../../../core/utils/themes/color.dart';
import '../../business_logic/cubit/home_cubit.dart';

Widget floatingButton(HomeCubit cubit) {
  return Positioned(
    bottom: 50,
    right: 20,
    child: GestureDetector(

      onTap: () async {
        cubit.changeTrueFloating();
        Future.delayed(const Duration(seconds: 7), () {
          cubit.changeFalseFloating();
        });
      },
      ///////////commit proplem
      child: Container(

        child: CircleAvatar(
          radius: 30,
          backgroundColor: AppColor.darkBlue,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: AppColor.lightBlue,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColor.darkBlue,
              child:  CircleAvatar(
                radius: 15,
                backgroundColor: AppColor.lightBlue,
                child:  CircleAvatar(
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
