import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

class SubMessageItem extends StatelessWidget {
  const SubMessageItem({
    Key? key,
    required this.userName,
    required this.userImage,
    required this.dateStr,
    required this.ayah,
    required this.ayahInfo,
    this.color = AppColor.selectColor1,
    this.action,
    this.userInfo,
    this.narrationName,
    this.isRead = false,
    this.isCertic = false,
    this.showPopup,
    this.hasMenu = false,
  }) : super(key: key);

  final String userName;
  final String userImage;
  final String? dateStr;
  final String ayah;
  final String ayahInfo;
  final Color color;
  final Function()? action;
  final Function()? showPopup;

  final String? userInfo;
  final String? narrationName;
  final bool isRead;
  final bool isCertic;
  final bool hasMenu;

  @override
  Widget build(BuildContext context) {
    print(baseUrl + userImage);
    return GestureDetector(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isRead ? color : AppColor.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: FadeInImage(
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                        placeholder: AssetImage(AppImages.duserImage),
                        image: NetworkImage(
                          (userImage.isNotEmpty)
                              ? (baseUrl + userImage)
                              : imgaTest,
                        )),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TextViewIcon(
                                text: userName,
                                weightText: FontWeight.w900,
                                padding: EdgeInsets.zero,
                                sizeText: 12,
                                colorText: AppColor.txtColor4,
                                icon: isRead
                                    ? Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                              const SizedBox(width: 8),
                              if (isRead)
                                Image.asset(
                                  AppIcons.qualityIcon,
                                  color: AppColor.gradient2,
                                  width: 12,
                                  height: 12,
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              if (dateStr != null)
                                Row(
                                  children: [
                                    TextView(
                                      padding: EdgeInsets.zero,
                                      text: dateStr ?? '',
                                      sizeText: 11,
                                      colorText: AppColor.txtColor4,
                                    ),
                                    Icon(
                                      Icons.bookmark_outline,
                                      size: 14,
                                      color: AppColor.txtColor4,
                                    )
                                  ],
                                ),
                              if (hasMenu)
                                GestureDetector(
                                    onTap: showPopup,
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.settings),
                                    ))
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (isRead)
                            const SizedBox(
                              width: 14,
                              height: 8,
                            ),
                          TextView(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            text: userInfo ?? 'Paid Teacher',
                            sizeText: 11,
                            colorText: AppColor.txtColor4,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      TextView(
                        padding: EdgeInsets.zero,
                        text: ayah,
                        sizeText: 20,
                        weightText: FontWeight.bold,
                        colorText:
                            isRead ? AppColor.txtColor3 : AppColor.txtColor4,
                        textAlign: TextAlign.start,
                        fontFamily: 'Hafs17',
                        // fontFamily: Q.hafs15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextView(
                          padding: EdgeInsets.zero,
                          text:
                              ayahInfo + ' - رواية ' + (narrationName ?? 'حفص'),
                          sizeText: 11,
                          colorText: AppColor.txtColor4,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
