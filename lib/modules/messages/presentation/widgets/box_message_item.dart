import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_item_sub.dart';

class BoxMessageItem extends StatelessWidget {
  const BoxMessageItem({
    Key? key,
    required this.userName,
    required this.userImage,
    required this.dateStr,
    required this.ayah,
    required this.ayahInfo,
    this.color = AppColor.selectColor1,
    this.action,
    this.isRead = false,
  }) : super(key: key);

  final String userName;
  final String userImage;
  final String? dateStr;
  final String ayah;
  final String ayahInfo;
  final Color color;
  final Function()? action;

  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SubMessageItem(
          action: action,
          isRead: isRead,
          color: color,
          userImage: userImage,
          userName: userName,
          dateStr: dateStr,
          ayah: ayah,
          ayahInfo: ayahInfo),
    );
  }
}

class ViewOld extends StatelessWidget {
  const ViewOld({
    Key? key,
    required this.action,
    required this.isActive,
    required this.color,
    required this.userImage,
    required this.userName,
    required this.dateStr,
    required this.ayah,
    required this.ayahInfo,
  }) : super(key: key);

  final Function()? action;
  final bool isActive;
  final Color color;
  final String userImage;
  final String userName;
  final String? dateStr;
  final String ayah;
  final String ayahInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isActive ? color : AppColor.transparent,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Image.asset(userImage),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextViewIcon(
                        text: userName,
                        weightText: FontWeight.w900,
                        padding: const EdgeInsets.all(1),
                        sizeText: 13,
                        colorText: AppColor.txtColor4,
                        icon: isActive
                            ? Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColor.gradient1,
                                      AppColor.gradient2
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      if (dateStr != null)
                        Row(
                          children: [
                            TextView(
                              padding: const EdgeInsets.all(1),
                              text: dateStr ?? '',
                              sizeText: 12,
                              colorText: AppColor.txtColor4,
                            ),
                            Icon(
                              Icons.bookmark_outline,
                              size: 14,
                              color: AppColor.txtColor4,
                            )
                          ],
                        )
                    ],
                  ),
                  TextView(
                    padding: const EdgeInsets.all(1),
                    text: ayah,
                    sizeText: 17,
                    weightText: FontWeight.w800,
                    colorText:
                        isActive ? AppColor.txtColor3 : AppColor.txtColor4,
                    textAlign: TextAlign.end,
                  ),
                  TextView(
                    padding: const EdgeInsets.all(1),
                    text: ayahInfo,
                    sizeText: 14,
                    colorText: AppColor.txtColor4,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
