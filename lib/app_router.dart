import 'package:flutter/material.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_base/modules/home/presentation/pages/coming_soon/coming_soon_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/home/home_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/recitations/recitations_page.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagetap_cubit.dart';
import 'package:flutter_base/modules/messages/presentation/pages/general_actions/liked_page.dart';
import 'package:flutter_base/modules/messages/presentation/pages/messages/messages_page.dart';
import 'package:flutter_base/modules/messages/presentation/pages/notify/notifiactions_page.dart';
import 'package:flutter_base/modules/quran/presentation/page/download_center_page.dart';
import 'package:flutter_base/modules/quran/presentation/page/index_surah_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/books_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/languages_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/narration_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/quran_translation_language_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/reciters_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/tafseer_page.dart';
import 'package:flutter_base/modules/teachers/business_logic/cubit/teacherviewtype_cubit.dart';
import 'package:flutter_base/modules/teachers/presentation/page/students_page.dart';
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
      case StudentsPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TeacherviewtypeCubit(),
            child: const StudentsPage(),
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
      case BooksPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const BooksPage(),
          settings: settings,
        );
      case LanguagesPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const LanguagesPage(),
          settings: settings,
        );
      case NarrationPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const NarrationPage(),
          settings: settings,
        );
      case QuranTranslationLanguagePage.routeName:
        return MaterialPageRoute(
          builder: (_) => const QuranTranslationLanguagePage(),
          settings: settings,
        );
      case RecitersPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const RecitersPage(),
          settings: settings,
        );
      case TafseerPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const TafseerPage(),
          settings: settings,
        );
      case ComingSoonPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const ComingSoonPage(),
          settings: settings,
        );
      case LikedPage.routeName:
        return MaterialPageRoute(
          builder: (_) => LikedPage(arg: (settings.arguments as int)),
          settings: settings,
        );
      case RecitationsPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const RecitationsPage(),
          settings: settings,
        );
      case NotifiactionsPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const NotifiactionsPage(),
          settings: settings,
        );
    }
    return null;
  }
}
