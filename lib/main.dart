import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:flutter_base/app_router.dart';
import 'package:flutter_base/core/bloc/app_bloc_observer.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/data/repository/database_repository.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

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

/*
  for (var item in List.generate(10, (index) => index)) {
    FileStorage().download2(
      'https://cdn-icons-png.flaticon.com/512/1581/1581942.png',
      '/docs/text.png',
      (received, total) {
        if (total != -1) {
          print('Downloads Main $item ' +
              (received / total * 100).toStringAsFixed(0) +
              '%');
        }
      },
    ).then(
      (value) {
        print('File Path' + value!.path);
      },
    );
  }

  FileStorage.writeCounter('deoc/text.png',
          'https://cdn-icons-png.flaticon.com/512/1581/1581942.png')
      .then(
    (value) {
      print('File Path' + value!.path);
    },
  );

  **/

  var index = (CacheHelper.getData(key: 'LanguagesSelected') as int?) ?? 1;

  if (index == 0) {
    isEn = true;
  } else {
    isEn = false;
  }

  await DataSource.initialApp(clientId: clientId, clientSecret: clientSecret);

  BlocOverrides.runZoned(
    () => runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/lang',
        startLocale: Locale(isEn ? 'en' : 'ar'),
        useOnlyLangCode: true,
        saveLocale: true,
        fallbackLocale: const Locale('ar'),
        useFallbackTranslations: true,
        child: MyApp(
          appRouter: AppRouter(),
        ),
        errorWidget: (message) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: TextView(
                  padding: const EdgeInsets.all(32),
                  text: message!.message.toString(),
                ),
              ),
            ),
          );
        },
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
      //showSemanticsDebugger: true,
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
