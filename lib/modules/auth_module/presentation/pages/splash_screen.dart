import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/onboard_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/home/home_page.dart';
import 'package:flutter_base/res.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constant/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5),() =>  Get.offAll(
      (token.isNotEmpty || token == '')
          ? const OnBoardPage(): const HomePage(),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
            alignment: Alignment.topCenter,
            children: [
          Image.asset(
            Res.splash,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            children:  [
               SizedBox(
                height: MediaQuery.of(context).size.height*2.8/4
              ),

              LinearProgressIndicator(minHeight: 10,color: AppColor.lightYellow,),
              const SizedBox(
                height: 20,
              ),
               Text(
                tr('Dawnloading...'),
                style: TextStyle(fontSize: 20,color: AppColor.lightYellow),
              ),

            ],
          )
        ]),
      ),
    );
  }
}
