import 'package:flutter/material.dart';
import '../../../../core/utils/constant/utils.dart';

import '../../../../core/utils/res/icons_app.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';

class ItemSurah extends StatelessWidget {
  const ItemSurah({
    Key? key,
    required this.name,
    required this.partName,
    required this.pageFrom,
    required this.pageTO,
    required this.verses,
    required this.onLongPress,
    this.action,
    this.isMakkah = true,
    this.isSelect = false,
  }) : super(key: key);

  final String name;
  final String partName;
  final int pageFrom;
  final int pageTO;
  final int verses;
  final bool isMakkah;
  final bool isSelect;
  final Function() onLongPress;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: action,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelect ? AppColor.borderColor : AppColor.conColor2,
            width: 1,
          ),
          color: AppColor.conColor2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              AppIcons.quran3Icon,
              width: 32,
              height: 32,
            ),
            TextView(
              text: name,
              colorText: AppColor.txtColor3,
              sizeText: 16,
              weightText: FontWeight.bold,
            ),
            TextView(
              text:
                  '${translate('Pages')} $pageFrom ${translate('to')} $pageTO',
              colorText: AppColor.txtColor4,
              sizeText: 12,
            ),
            TextView(
              text: '${translate('Verses')}  $verses',
              colorText: AppColor.txtColor4,
              sizeText: 12,
            ),
            TextView(
              text: partName,
              colorText: AppColor.txtColor4,
              sizeText: 12,
            ),
            Image.asset(
              isMakkah ? AppIcons.makkahIcon : AppIcons.medinaIcon,
              width: 28,
              height: 28,
            ),
          ],
        ),
      ),
    );
  }
}
