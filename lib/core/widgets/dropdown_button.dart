import 'package:flutter/material.dart';

import 'text_view.dart';

class DropdownButtonApp extends StatelessWidget {
  const DropdownButtonApp({
    Key? key,
    required this.list,
    required this.onChanged,
    this.title,
  }) : super(key: key);

  final List<String> list;
  final String? title;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: title != null
          ? TextView(
              text: title!,
              textAlign: TextAlign.end,
              sizeText: 14,
              colorText: Theme.of(context).primaryColor,
            )
          : Container(),
      //value: title,
      dropdownColor: Theme.of(context).primaryColor,
      underline: Container(
        height: 0,
      ),
      iconSize: 32,
      elevation: 4,
      onChanged: onChanged,
      icon: Icon(
        Icons.arrow_drop_down,
        color: Theme.of(context).primaryColor,
      ),
      items: [
        ...list.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.start,
            ),
          );
        }).toList()
      ],
    );
  }
}
