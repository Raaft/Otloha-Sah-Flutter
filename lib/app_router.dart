import 'package:flutter/material.dart';
import 'package:flutter_base/modules/quran/presentation/page/download_center_page.dart';
import 'package:flutter_base/modules/quran/presentation/page/index_surah_page.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_base/modules/home/presentation/pages/home/home_page.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagetap_cubit.dart';
import 'package:flutter_base/modules/messages/presentation/pages/messages/messages_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings_page.dart';
import 'package:flutter_base/modules/teachers/business_logic/cubit/teacherviewtype_cubit.dart';
import 'package:flutter_base/modules/teachers/presentation/page/teacher_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  AppRouter();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => HomeCubit(),
            child: const HomePage(),
          ),
          settings: settings,
        );
      case MessagesPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MessageTapCubit(),
            child: const MessagesPage(),
          ),
          settings: settings,
        );
      case TeacherPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TeacherviewtypeCubit(),
            child: const TeacherPage(),
          ),
          settings: settings,
        );
      case IndexSurahPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const IndexSurahPage(),
          settings: settings,
        );
      case DownloadCenterPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const DownloadCenterPage(),
          settings: settings,
        );
      case SettingsPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
          settings: settings,
        );
    }
    return null;
  }
}
