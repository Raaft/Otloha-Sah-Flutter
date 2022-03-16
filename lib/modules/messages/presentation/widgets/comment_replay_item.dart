import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/modules/messages/presentation/pages/messages/replay_message_page.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/lib_edit/wave/just_waveform.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/wave_view.dart';

class CommentReplayItem extends StatelessWidget {
  const CommentReplayItem({
    Key? key,
    required this.userName,
    required this.userImage,
    this.dateStr,
    required this.ayah,
    required this.ayahInfo,
    required this.color,
    required this.errorStr,
    this.action,
    this.userInfo,
    this.errorType,
    this.narrationName,
    this.isReplay = false,
    required this.isRead,
    required this.progressStream,
    required this.isPlay,
    required this.trggelPlay,
  }) : super(key: key);

  final String userName;
  final String userImage;
  final String? dateStr;
  final String ayah;
  final String ayahInfo;
  final String errorStr;
  final Color color;
  final Function()? action;

  final String? userInfo;
  final String? errorType;
  final String? narrationName;
  final bool isRead;

  final BehaviorSubject<WaveformProgress> progressStream;

  final bool isPlay;
  final bool isReplay;

  final Function() trggelPlay;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(6),
        margin: isReplay
            ? EdgeInsets.only(left: isEn ? 48 : 0, right: isEn ? 0 : 48)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  // margin: const EdgeInsets.all(4),
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image.asset(userImage),
                  ),
                ),
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
                              TextView(
                                text: userName,
                                weightText: FontWeight.w900,
                                padding: EdgeInsets.zero,
                                sizeText: 12,
                                colorText: AppColor.txtColor4,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (isRead)
                                const SizedBox(
                                  width: 14,
                                  height: 8,
                                ),
                              TextView(
                                padding: EdgeInsets.zero,
                                text: userInfo ?? 'Paid Teacher',
                                sizeText: 11,
                                colorText: AppColor.txtColor4,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColor.gradient1,
                            ),
                            child: TextView(
                              padding: EdgeInsets.zero,
                              text: errorType ?? 'نوع الخطاء : تجويد',
                              sizeText: 11,
                              colorText: AppColor.txtColor4,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      TextView(
                        padding: EdgeInsets.zero,
                        text: ayah,
                        sizeText: 16,
                        weightText: FontWeight.bold,
                        colorText:
                            isRead ? AppColor.txtColor3 : AppColor.txtColor4,
                        textAlign: TextAlign.start,
                        //  fontFamily: Q.hafs15,
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
                      WaveViewPlayAudio(
                          progressStream: progressStream,
                          trggelPlay: trggelPlay,
                          isPlay: isPlay),
                      TextView(
                        text: errorStr,
                        padding: EdgeInsets.zero,
                        sizeText: 14,
                        colorText: AppColor.txtColor4,
                        textAlign: TextAlign.start,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      TextView(
                        text: 'رد',
                        padding: EdgeInsets.zero,
                        sizeText: 14,
                        weightText: FontWeight.w700,
                        colorText: AppColor.txtColor4,
                        textAlign: TextAlign.start,
                        action: () {
                          Get.to(const ReplayMesaagePage());
                        },
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
