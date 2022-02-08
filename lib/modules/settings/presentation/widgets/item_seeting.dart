import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

import 'package:flutter_base/modules/settings/data/models/setting.dart';

class ItemSetting extends StatelessWidget {
  const ItemSetting({
    Key? key,
    required this.settings,
  }) : super(key: key);

  final Settings settings;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(settings.actionTo ?? '');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Card(
          //    color: AppColor.gradient1,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  settings.image,
                  width: 40,
                  height: 40,
                  color: AppColor.txtColor3,
                ),
                TextView(
                  text: settings.name,
                  colorText: AppColor.txtColor3,
                  sizeText: 16,
                  weightText: FontWeight.w900,
                  padding: const EdgeInsets.all(2),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
