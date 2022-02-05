import 'package:flutter/material.dart';

import 'modules/auth_module/presentation/pages/login_page.dart';
import 'modules/auth_module/presentation/pages/sign_up.dart';




class AppRouter {
  AppRouter();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (_) =>  LoginPage(),
          settings: settings,
        );
      case SignUpPage.routeName:
        return MaterialPageRoute(
          builder: (_) =>  LoginPage(),
          settings: settings,
        );
    }
  }
}
