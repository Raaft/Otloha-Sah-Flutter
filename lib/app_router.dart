import 'package:flutter/material.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/onboard_page.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/splash_screen.dart';
import 'package:flutter_base/modules/home/presentation/pages/coming_soon/coming_soon_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/home/home_page.dart';
import 'package:flutter_base/modules/recitations/presentation/page/recitations_page.dart';
import 'package:flutter_base/modules/messages/presentation/pages/general_actions/liked_page.dart';
import 'package:flutter_base/modules/messages/presentation/pages/notify/notifiactions_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/chapter_download_page.dart';
import 'package:flutter_base/modules/quran/presentation/page/chapters/index_surah_page.dart';
import 'package:flutter_base/modules/quran/presentation/page/action_pages/pages_liked_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/books_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/languages_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/narration_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/quran_translation_language_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/reciters_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/tafseer_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/tajweed_page.dart';
import 'package:flutter_base/modules/teachers/presentation/page/students_page.dart';
import 'package:flutter_base/modules/teachers/presentation/page/teacher_page.dart';

import 'data_source/local/database/database_repository.dart';
import 'modules/messages/presentation/pages/messages/layout_page.dart';
import 'modules/quran/presentation/page/action_pages/bookmark_bage.dart';
import 'modules/quran/presentation/page/action_pages/note_page.dart';

class AppRouter {
  late DatabaseRepository databaseRepository;

  AppRouter() {
    databaseRepository = DatabaseRepository();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnBoardPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const OnBoardPage(),
          settings: settings,
        );
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
          settings: settings,
        );
        case PagesNotePage.routeName:
        return MaterialPageRoute(
          builder: (_) => const PagesNotePage(),
          settings: settings,
        );
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
        case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case MessagesPage.routeName:
        return MaterialPageRoute(
          builder: (_) =>  const MessagesPage(),
          settings: settings,
        );
      case TeacherPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const TeacherPage(),
          settings: settings,
        );
      case StudentsPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const StudentsPage(),
          settings: settings,
        );
      case IndexSurahPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const IndexSurahPage(),
          settings: settings,
        );
      case ChapterDownloadPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const ChapterDownloadPage(),
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
      case PagesLikedPage.routeName:
        return MaterialPageRoute(
          builder: (_) => PagesLikedPage(arg: (settings.arguments as int)),
          settings: settings,
        );
      case PagesBookMarkPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const PagesBookMarkPage(),
          settings: settings,
        );
      case RecitationsPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const RecitationsPage(),
          settings: settings,
        );
      case TajweedPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const TajweedPage(),
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
