import 'package:flutter/widgets.dart';

class BottomBarData {
  String title;
  String iconData;
  bool isBadge;
  int badge;
  Color badgeColor;
  Widget page;
  BottomBarData({
    required this.title,
    required this.iconData,
    required this.badgeColor,
    required this.page,
    this.isBadge = false,
    this.badge = 0,
  });
}
