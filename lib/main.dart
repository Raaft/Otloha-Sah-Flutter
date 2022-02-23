import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/plugin_aut/plugin_auth.dart';
import 'package:flutter_base/plugin_aut/plugin_web_servise.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:flutter_base/app_router.dart';
import 'package:flutter_base/core/bloc/app_bloc_observer.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/data/repository/database_repository.dart';

import 'core/utils/constant/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

//init DateBase
  await DatabaseRepository().initDb;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColor.statusBarColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await CacheHelper.init();

  var index = (CacheHelper.getData(key: 'LanguagesSelected') as int?) ?? 0;

  if (index == 0) {
    isEn = true;
  } else {
    isEn = false;
  }

  DioHelper.init();

  BlocOverrides.runZoned(
    () => runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/lang', // <- change the path of the translation files
        //fallbackLocale: const Locale('en'),
        startLocale: Locale(isEn ? 'en' : 'ar'),
        useOnlyLangCode: true,
        //useFallbackTranslations: true,
        saveLocale: true,
        child: MyApp(
          appRouter: AppRouter(),
        ),
      ),
    ),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;

  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    PluginAuth().pluginAuth(
      url: '/o/token/',
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: widget.appRouter.generateRoute,
    );
  }
}
