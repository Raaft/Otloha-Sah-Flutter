// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class IconButtonApp extends StatelessWidget {
  final Function() action;
  Widget icon;
  bool isFullWidth = false;
  Color? bcolor;
  TextStyle style;

  IconButtonApp({
    Key? key,
    required this.action,
    required this.icon,
    this.isFullWidth = false,
    this.bcolor,
    this.style = const TextStyle(fontSize: 20, color: Colors.white),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bcolor = (bcolor == null) ? Theme.of(context).primaryColor : bcolor;
    return Container(
      padding: const EdgeInsets.all(16.0),
      // width: isFullWidth ? MediaQuery.of(context).size.width : null,
      child: FloatingActionButton(
        backgroundColor: bcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: icon,
        ),
        onPressed: action,
      ),
    );
  }
}
