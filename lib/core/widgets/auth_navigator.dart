import 'package:flutter/material.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';

class AuthNavigator extends StatefulWidget {
  const AuthNavigator({required this.child}) : super();

  final Widget child;

  static _AuthNavigatorState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AuthNavigatorState>();

  @override
  _AuthNavigatorState createState() => _AuthNavigatorState();
}

class _AuthNavigatorState extends State<AuthNavigator> {
  Future pushConditionally<T extends Object>(
          BuildContext context, String route, bool condition) =>
      condition
          ? Navigator.pushNamed(
              context,
              LoginPage.routeName,
            )
          : Navigator.pushNamed(
              context,
              route,
            );

  @override
  Widget build(BuildContext context) => widget.child;
}
