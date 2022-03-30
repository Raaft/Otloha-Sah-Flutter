import 'dart:async';

import 'package:flutter/material.dart';
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
    Future.delayed(const Duration(seconds: 5),() =>  Get.to(
      (token.isNotEmpty || token == '')
          ? const HomePage()
          : const OnBoardPage(),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Image.asset(
            Res.splash,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            children: const [
              LinearProgressIndicator(minHeight: 10),
              SizedBox(
                height: 20,
              ),
              Text(
                'Dawnloading',
                style: TextStyle(fontSize: 20),
              )
            ],
          )
        ]),
      ),
    );
  }
}
