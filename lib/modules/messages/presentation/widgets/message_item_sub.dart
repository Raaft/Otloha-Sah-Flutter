import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/widgets/cached_image.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/home/presentation/widget/popup_recitation.dart';
import 'package:get/get.dart';

import '../../../../data_source/models/database_model/GeneralResponse.dart';
import '../../../../data_source/models/home_models/user_prfile.dart';

class SubMessageItem extends StatelessWidget {
  const SubMessageItem({
    Key? key,
    required this.userName,
    required this.userImage,
    required this.dateStr,
    required this.ayah,
    required this.ayahInfo,
    this.color = AppColor.messageColor,
    this.action,
    this.userInfo,
    this.narrationName,
    this.isRead = false,
    this.isCertic = false,
    this.showPopup,
    this.hasMenu = false,
    this.owner,
    required this.id,
  }) : super(key: key);

  final int id;
  final String userName;
  final String userImage;
  final String? dateStr;
  final String ayah;
  final String ayahInfo;
  final Color color;
  final Function()? action;
  final Function()? showPopup;
  final Owner? owner;

  final String? userInfo;
  final String? narrationName;
  final bool isRead;
  final bool isCertic;
  final bool hasMenu;

  @override
  Widget build(BuildContext context) {
    print(baseUrl + userImage);
    return InkWell(
      onLongPress: () {
        UserProfile user = UserProfile.fromJson(
            json.decode(CacheHelper.getData(key: profile)));
        print(CacheHelper.getData(key: profile));
        if ((user.id != owner!.id) && user.isATeacher!) {
          Get.bottomSheet(
            PopupRecitation(
              actions: const [
                PopupActions.addToGeneral,
                PopupActions.delete,
                PopupActions.send,
                PopupActions.createMessge,
              ],
              isOwner: user.id == owner!.id,
              finishedAt: dateStr ?? '',
              id: id,
              isTeacher: user.isATeacher!,
              showInGeneral: true,
            ),
          );
        }
      },
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromARGB(51, 212, 248, 255),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachedImage(url: userImage, raduis: 36),
                  const SizedBox(width: 8),
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
                                  letterSpacing: 0.4,
                                  colorText: AppColor.userNameColor,
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
                                        text: dateStr!.toUpperCase(),
                                        sizeText: 12,
                                        colorText: AppColor.txtColor4,
                                      ),
                                      const Icon(
                                        Icons.bookmark_outline,
                                        size: 12,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                if (hasMenu)
                                  GestureDetector(
                                    onTap: showPopup,
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.settings),
                                    ),
                                  )
                              ],
                            ),
                          ],
                        ),
                        TextView(
                          padding: EdgeInsets.zero,
                          text: ayah,
                          sizeText: 16,
                          weightText: FontWeight.bold,
                          colorText: AppColor.headTextColor,
                          textAlign: TextAlign.start,
                          fontFamily: 'Hafs17',
                          // fontFamily: Q.hafs15,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextView(
                            padding: EdgeInsets.zero,
                            text: ayahInfo +
                                ' - رواية ' +
                                (narrationName ?? 'حفص'),
                            sizeText: 12,
                            colorText: AppColor.userNameColor,
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
      ),
    );
  }
}
