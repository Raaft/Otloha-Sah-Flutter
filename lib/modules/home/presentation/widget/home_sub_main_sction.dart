import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/home/data/models/utils/sub_section_item.dart';

class HomeSubMainSection extends StatelessWidget {
  const HomeSubMainSection({Key? key, required this.item}) : super(key: key);

  final SubSectionItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(item.action ?? '');
      },
      child: Container(
        height: 80,
        width: 80,
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.gradient3, AppColor.gradient3],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              item.image,
              width: 32,
              height: 32,
            ),
            TextView(
              text: item.title,
              colorText: AppColor.txtColor3,
              sizeText: 12,
              weightText: FontWeight.w700,
              padding: const EdgeInsets.all(2),
              textAlign: TextAlign.center,
            ),
            //if (item.subTitle != null && item.subTitle!.isNotEmpty)
            TextView(
              text: item.subTitle ?? '',
              colorText: AppColor.txtColor4,
              sizeText: 8,
              padding: const EdgeInsets.all(2),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}