// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/modules/auth_module/business_logic/auth_cubit.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/onboard_page.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/teachersend_cubit.dart';
import 'package:flutter_base/modules/home/data/models/user/user_prfile.dart';
import 'package:flutter_base/modules/home/presentation/pages/home/home_page.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/reply_cubit.dart';
import 'package:flutter_base/modules/settings/business_logic/settings/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quran_widget_flutter/helper/chash_helper.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';
import 'package:flutter_base/core/data/chash_helper.dart' as otloha_shaerd;

import 'package:flutter_base/app_router.dart';
import 'package:flutter_base/core/bloc/app_bloc_observer.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/data/repository/database_repository.dart';

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

  await otloha_shaerd.CacheHelper.init();
  await CacheHelper.init();
  token = await CacheHelper.getData(key: 'token') ?? '';

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

  var index = (CacheHelper.getData(key: languagesSelectedId) as int?) ?? 1;

  if (index == 0) {
    isEn = true;
  } else {
    isEn = false;
  }

  await DataSource.initialApp(clientId: clientId, clientSecret: clientSecret);

  try {
    myProFile ==
        UserProfile.fromJson(jsonDecode(
            await otloha_shaerd.CacheHelper.getData(key: userProfileLogined)));
    favTeacherProFile = UserProfile.fromJson(
        jsonDecode(await otloha_shaerd.CacheHelper.getData(key: favTeacher)));
  } catch (e) {
    print('no user login');
  }

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ReplyCubit(),
        ),
        BlocProvider(
          create: (context) => TeachersendCubit(),
        ),
      ],
      child: GetMaterialApp(
        //showSemanticsDebugger: true,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute:
            (token.isNotEmpty) ? HomePage.routeName : OnBoardPage.routeName,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
