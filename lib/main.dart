import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:flutter_base/app_router.dart';
import 'package:flutter_base/core/bloc/app_bloc_observer.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/data/repository/database_repository.dart';
import 'package:quran_widget_flutter/plugin_aut/plugin_web_servise.dart';

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

  QuranWidgetInit.init(clientId: clientId, clientSecret: clientSecret);

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

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

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
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
