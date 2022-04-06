import 'package:flutter/material.dart';

import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';
import '../../../quran/business_logic/cubit/getuserquranaction_cubit.dart';

class UserLiked extends StatelessWidget {
  const UserLiked(
      {Key? key,
      required this.userName,
      required this.userImage,
      this.note,
      this.action,
      this.index,
      this.id,  })
      : super(key: key);

  final String userName;
  final String userImage;
  final int? index;
  final int? id;
  final String? note;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColor.transparent,
            width: 2,
          ),
          color: AppColor.backItem,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      userImage,
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextView(
                      text: userName,
                      colorText: AppColor.txtColor3,
                      sizeText: 16,
                      weightText: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                    if (note != null)
                      TextView(
                        text: note ?? '',
                        colorText: AppColor.txtColor4,
                        sizeText: 14,
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
