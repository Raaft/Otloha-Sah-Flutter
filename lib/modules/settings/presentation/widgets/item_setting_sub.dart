import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/home/data/models/utils/sub_section_item.dart';
import 'package:flutter_base/modules/home/presentation/widget/home_sub_main_sction.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Card(
            color: AppColor.gradient3,
            elevation: 0,
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
      ),
    );
  }
}
