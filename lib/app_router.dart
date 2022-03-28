import 'package:flutter/material.dart';
import 'package:flutter_base/data_source/local/database/database_repository.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/onboard_page.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/userrecitation_cubit.dart';
import 'package:flutter_base/modules/home/presentation/pages/coming_soon/coming_soon_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/home/home_page.dart';
import 'package:flutter_base/modules/home/presentation/pages/recitations/recitations_page.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagetap_cubit.dart';
import 'package:flutter_base/modules/messages/presentation/pages/general_actions/liked_page.dart';
import 'package:flutter_base/modules/messages/presentation/pages/messages/messages_page.dart';
import 'package:flutter_base/modules/messages/presentation/pages/notify/notifiactions_page.dart';
import 'package:flutter_base/modules/plugin_creation/domain/plugin_cubit/plugin_cubit.dart';
import 'package:flutter_base/modules/quran/business_logic/cubit/getuserquranaction_cubit.dart';
import 'package:flutter_base/modules/settings/business_logic/chapter/chapter_cubit.dart';
import 'package:flutter_base/modules/settings/business_logic/recitation/recitation_cubit.dart';
import 'package:flutter_base/modules/settings/business_logic/reciter/reciter_cubit.dart';
import 'package:flutter_base/modules/settings/business_logic/settings/settings_cubit.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/chapter_download_page.dart';
import 'package:flutter_base/modules/quran/presentation/page/index_surah_page.dart';
import 'package:flutter_base/modules/quran/presentation/page/pages_liked_page.dart';
import 'package:flutter_base/modules/settings/business_logic/book/book_cubit.dart';
import 'package:flutter_base/modules/settings/business_logic/language/language_cubit.dart';
import 'package:flutter_base/modules/settings/business_logic/narration/narration_cubit.dart';
import 'package:flutter_base/modules/settings/business_logic/tajweed/tajweed_cubit.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/books_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/languages_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/narration_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/quran_translation_language_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/reciters_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/tafseer_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/settings/tajweed_page.dart';
import 'package:flutter_base/modules/teachers/business_logic/cubit/teacherviewtype_cubit.dart';
import 'package:flutter_base/modules/teachers/presentation/page/students_page.dart';
import 'package:flutter_base/modules/teachers/presentation/page/teacher_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late DatabaseRepository databaseRepository;

  AppRouter() {
    databaseRepository = DatabaseRepository();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnBoardPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => HomeCubit(),
            child: const OnBoardPage(),
          ),
          settings: settings,
        );
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => HomeCubit(),
            child: LoginPage(),
          ),
          settings: settings,
        );
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<HomeCubit>(
                create: (BuildContext context) => HomeCubit(),
              ),
              BlocProvider<PluginCubit>(
                create: (BuildContext context) => PluginCubit(),
              ),
            ],
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
          builder: (_) => BlocProvider(
            create: (context) => ChapterCubit(),
            child: const IndexSurahPage(),
          ),
          settings: settings,
        );
      case ChapterDownloadPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ChapterCubit(),
            child: const ChapterDownloadPage(),
          ),
          settings: settings,
        );
      case SettingsPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SettingsCubit(),
            child: const SettingsPage(),
          ),
          settings: settings,
        );
      case BooksPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BookCubit(),
            child: const BooksPage(),
          ),
          settings: settings,
        );
      case LanguagesPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LanguageCubit(),
            child: const LanguagesPage(),
          ),
          settings: settings,
        );
      case NarrationPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => NarrationCubit(),
            child: const NarrationPage(),
          ),
          settings: settings,
        );
      case QuranTranslationLanguagePage.routeName:
        return MaterialPageRoute(
          builder: (_) => const QuranTranslationLanguagePage(),
          settings: settings,
        );
      case RecitersPage.routeName:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ReciterCubit()),
              BlocProvider(create: (context) => RecitationCubit()),
            ],
            child: const RecitersPage(),
          ),
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
          builder: (_) => BlocProvider(
            create: (context) => GetUserQuranActionCubit(databaseRepository),
            child: PagesLikedPage(arg: (settings.arguments as int)),
          ),
          settings: settings,
        );
      case PagesBookMarkPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => GetUserQuranActionCubit(databaseRepository),
            child: const PagesBookMarkPage(),
          ),
          settings: settings,
        );
      case RecitationsPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UserRecitationCubit(),
            child: const RecitationsPage(),
          ),
          settings: settings,
        );
      case TajweedPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TajweedCubit(),
            child: const TajweedPage(),
          ),
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
