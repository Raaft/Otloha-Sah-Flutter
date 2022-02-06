import 'package:flutter/material.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/onboard_page.dart';

import 'modules/auth_module/presentation/pages/login_page.dart';
import 'modules/auth_module/presentation/pages/sign_up.dart';

class AppRouter {
  AppRouter();

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
      case SignUpPage.routeName:
        return MaterialPageRoute(
          builder: (_) => SignUpPage(),
          settings: settings,
        );
    }
  }
}
