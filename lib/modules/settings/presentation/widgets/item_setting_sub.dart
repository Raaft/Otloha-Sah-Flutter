import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

import '../../data/models/setting.dart';

class ItemSubSetting extends StatelessWidget {
  const ItemSubSetting({
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
          //color: AppColor.gradient1,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              //  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  settings.image,
                  width: 32,
                  height: 32,
                  color: AppColor.txtColor3,
                ),
                const SizedBox(width: 8),
                TextView(
                  text: settings.name,
                  colorText: AppColor.txtColor3,
                  sizeText: 16,
                  weightText: FontWeight.w900,
                  padding: const EdgeInsets.all(2),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
