import 'package:flutter/material.dart';

import 'package:flutter_base/modules/home/data/models/utils/sub_section_item.dart';
import 'package:flutter_base/modules/home/presentation/widget/home_sub_main_sction.dart';

import 'package:flutter_base/modules/settings/data/models/setting.dart';

class ItemSetting extends StatelessWidget {
  const ItemSetting({Key? key, required this.settings, required this.change})
      : super(key: key);

  final Settings settings;
  final Function() change;

  @override
  Widget build(BuildContext context) {
    return HomeSubMainSection(
      item: SubSectionItem(
          title: settings.name,
          image: settings.image,
          action2: (context) {
            Navigator.of(context)
                .pushNamed(settings.actionTo ?? '')
                .then((_) => change());
          },
          subTitle: settings.subTitle),
    );
  }
}
