import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/home/data/models/utils/sub_section_item.dart';
import 'package:flutter_base/modules/home/presentation/widget/home_sub_main_sction.dart';

import 'package:flutter_base/modules/settings/data/models/setting.dart';

class ItemSetting extends StatelessWidget {
  const ItemSetting({
    Key? key,
    required this.settings,
  }) : super(key: key);

  final Settings settings;

  @override
  Widget build(BuildContext context) {
    return HomeSubMainSection(
      item: SubSectionItem(
        title: settings.name,
        image: settings.image,
        action: settings.actionTo,
      ),
    );
  }
}
