import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/utils/themes/text_style.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

class SelectableMessageItem extends StatelessWidget {
  const SelectableMessageItem({
    Key? key,
    required this.userName,
    required this.userImage,
    this.dateStr,
    required this.ayah,
    required this.ayahInfo,
    required this.color,
    this.action,
    this.userInfo,
    this.narrationName,
    required this.isRead,
    required this.isCertic,
    required this.selectedText,
  }) : super(key: key);

  final String userName;
  final String userImage;
  final String? dateStr;
  final String ayah;
  final String ayahInfo;
  final Color color;
  final Function()? action;
  final Function(TextSelection) selectedText;

  final String? userInfo;
  final String? narrationName;
  final bool isRead;
  final bool isCertic;

  @override
  Widget build(BuildContext context) {
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
                            )
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
                      SelectableText(
                        ayah,
                        textAlign: TextAlign.start,
                        showCursor: true,
                        cursorRadius: const Radius.circular(16),
                        cursorWidth: 1,
                        onSelectionChanged: sele,
                        toolbarOptions:
                            const ToolbarOptions(copy: false, selectAll: false),
                        style: AppStyle().textStyle1.copyWith(
                            fontSize: 20,
                            color: AppColor.txtColor4,
                            fontWeight: FontWeight.bold,
                            wordSpacing: .5,
                            fontFamily: 'Hafs17'),
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

  void sele(TextSelection selection, SelectionChangedCause? cause) {
    selectedText(selection);
  }
}
