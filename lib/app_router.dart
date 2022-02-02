import 'package:flutter/material.dart';

import 'modules/login/presentation/pages/login_page.dart';


class AppRouter {
  AppRouter();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (_) =>  LoginPage(),
          settings: settings,
        );
    }
  }
}
