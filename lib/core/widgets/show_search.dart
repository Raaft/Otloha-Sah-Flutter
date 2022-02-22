import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/person.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/utils/themes/text_style.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:search_page/search_page.dart';

shoow(BuildContext context) {
  showSearch(
    context: context,
    delegate: SearchPage<Object>(
      items: people,
      searchLabel: 'Search people',
      suggestion: const Center(
        child: TextView(text: 'Filter people by name, surname or age'),
      ),
      failure: const Center(
        child: TextView(text: 'No person found :('),
      ),
      filter: (person) => [
        (person as Person).name,
        (person).surname,
        (person).age.toString(),
      ],
      builder: (person) => ListTile(
        title: Text((person as Person).name),
        subtitle: Text((person).surname),
        trailing: Text('${(person).age} yo'),
      ),
      searchStyle: AppStyle().textStyle1,
      barTheme: Theme.of(context).copyWith(
        backgroundColor: AppColor.background1,
        canvasColor: AppColor.background1,
        iconTheme: IconThemeData(
          color: AppColor.txtColor1,
        ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: AppColor.background1,
              elevation: .5,
              foregroundColor: AppColor.txtColor4d,
            ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: AppColor.txtColor4,
            fontSize: 20,
          ),
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
    ),
  );
}
