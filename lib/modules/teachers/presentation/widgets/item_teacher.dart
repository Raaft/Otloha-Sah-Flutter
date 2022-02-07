import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

class ItemTeacher extends StatelessWidget {
  const ItemTeacher({
    Key? key,
    required this.userName,
    required this.rate,
    required this.userId,
    required this.userbio,
    required this.action,
    required this.typeView,
    this.isCertified = false,
  }) : super(key: key);

  final bool typeView;
  final bool isCertified;

  final String userName;
  final String rate;
  final String userId;
  final String userbio;

  final Function()? action;

  @override
  Widget build(BuildContext context) {
    final Widget view;

    if (typeView) {
      view = Row(
        /// crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _userImage(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(
                        text: userName,
                        weightText: FontWeight.bold,
                        padding: const EdgeInsets.all(2),
                        sizeText: 18,
                        colorText: AppColor.txtColor4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: rate,
                            weightText: FontWeight.bold,
                            padding: const EdgeInsets.all(2),
                            sizeText: 18,
                            colorText: AppColor.txtColor4,
                          ),
                          Row(
                            children: [
                              ..._iconsView(20),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextView(
                        text: userId,
                        padding: const EdgeInsets.all(2),
                        sizeText: 16,
                        colorText: AppColor.txtColor4,
                        // textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  TextView(
                    text: userbio,
                    padding: const EdgeInsets.all(2),
                    sizeText: 14,
                    colorText: AppColor.txtColor4,
                    textAlign: TextAlign.start,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          )
        ],
      );
    } else {
      view = Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _userImage(),
            TextView(
              text: userName,
              weightText: FontWeight.bold,
              padding: const EdgeInsets.all(2),
              sizeText: 18,
              colorText: AppColor.txtColor4,
            ),
            Row(
              children: [
                TextView(
                  text: userId,
                  padding: const EdgeInsets.all(2),
                  sizeText: 14,
                  colorText: AppColor.txtColor4,
                  textAlign: TextAlign.start,
                ),
                TextView(
                  text: rate,
                  weightText: FontWeight.bold,
                  padding: const EdgeInsets.all(2),
                  sizeText: 14,
                  colorText: AppColor.txtColor4,
                  textAlign: TextAlign.start,
                ),
                ..._iconsView(16),
              ],
            ),
            const SizedBox(height: 8),
            TextView(
              text: userbio,
              padding: const EdgeInsets.all(2),
              sizeText: 12,
              colorText: AppColor.txtColor4,
              textAlign: TextAlign.start,
              // overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    return Card(
      elevation: 0,
      color: AppColor.backItem,
      child: GestureDetector(
        onTap: action,
        child: Container(
          padding: const EdgeInsets.all(4),
          child: view,
        ),
      ),
    );
  }

  SizedBox _userImage() {
    return SizedBox(
      width: 70,
      height: 70,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(AppImages.duserImage),
      ),
    );
  }

  List<Widget> _iconsView(double size) {
    return [
      Icon(
        Icons.star_border,
        color: AppColor.iconColor3,
        size: size,
      ),
      Icon(
        Icons.favorite_border,
        color: AppColor.iconColor,
        size: size,
      ),
      if (isCertified)
        Image.asset(
          AppIcons.qualityIcon,
          color: AppColor.iconColor5,
          width: size,
          height: size,
        ),
    ];
  }
}
