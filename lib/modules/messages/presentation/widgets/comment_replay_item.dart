import 'package:flutter/material.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_widget.dart';
import '../../../../core/utils/constant/constants.dart';

import '../../../../core/utils/res/icons_app.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';
import 'wave_view.dart';

import '../../../../data_source/models/message_model/error_type.dart';

class CommentReplayItem extends StatelessWidget {
  const CommentReplayItem({
    Key? key,
    required this.userName,
    required this.userImage,
    this.dateStr,
    required this.ayah,
    this.ayahInfo,
    required this.color,
    this.errorStr,
    this.action,
    this.userInfo,
    this.errorType,
    this.narrationName,
    this.onLongPress,
    this.isReply = false,
    this.isLocal = false,
    required this.isRead,
    required this.isPlay,
    required this.trggelPlay,
    this.actionReply,
    required this.recordPath,
    required this.wavePath,
    this.small = false,
  }) : super(key: key);

  final String? userName;
  final String? userImage;
  final String? dateStr;
  final String? ayah;
  final String? ayahInfo;
  final String? errorStr;
  final Color color;
  final Function()? action;

  final String? recordPath;
  final String? wavePath;

  final String? userInfo;
  final String? errorType;
  final String? narrationName;
  final bool isRead;
  final bool isLocal;

  final bool isPlay;
  final bool isReply;
  final bool small;

  final Function() trggelPlay;
  final Function()? actionReply;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isReply
          ? EdgeInsets.only(left: isEn ? 48 : 0, right: isEn ? 0 : 48)
          : EdgeInsets.zero,
      child: MessageWidget(
        onLongPress: onLongPress,
        userImage: userImage,
        small: isReply || small,
        userName: _viwName(),
        dataView: _viewData(),
        ayahView: _viewAyah(),
        ayahInfoView: _ayahInfoView(),
        userInfo: _userInfo(),
        color: AppColor.selectColor1,
      ),
    );
  }

  Row _viewData() {
    return Row(
      children: [
        TextView(
          padding: EdgeInsets.zero,
          text: dateStr?.toUpperCase() ?? '',
          sizeText: 10,
          colorText: AppColor.txtColor4,
        ),
        const Icon(
          Icons.bookmark_outline,
          size: 12,
          color: Colors.black,
        )
      ],
    );
  }

  TextView _viwName() {
    return TextView(
      text: userName ?? 'Name',
      weightText: FontWeight.w900,
      padding: EdgeInsets.zero,
      sizeText: 10,
      letterSpacing: 0.4,
      colorText: AppColor.userNameColor,
    );
  }

  _userInfo() {
    var errorTypeActiv = _check(errorType) ?? ErrorType.errors[0];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        if (errorType != null && errorType!.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: errorTypeActiv.color,
            ),
            child: TextView(
              padding: EdgeInsets.zero,
              text: 'نوع الخطاء : ' + (errorTypeActiv.value ?? 'تجويد'),
              sizeText: 11,
              colorText: AppColor.txtColor2,
              textAlign: TextAlign.start,
            ),
          ),
      ],
    );
  }

  _viewAyah() {
    return (ayah != null && ayah!.isNotEmpty)
        ? SizedBox(
            child: TextView(
              padding: EdgeInsets.zero,
              text: ayah ?? '',
              sizeText: 18,
              weightText: FontWeight.w900,
              colorText: AppColor.headTextColor,
              textAlign: TextAlign.start,
              fontFamily: 'Hafs17',
            ),
          )
        : Container();
  }

  _ayahInfoView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          padding: EdgeInsets.zero,
          text: (ayahInfo ?? '') + ' - رواية ' + (narrationName ?? 'حفص'),
          sizeText: 12,
          colorText: AppColor.userNameColor,
          textAlign: TextAlign.start,
        ),
        ..._waveView(),
      ],
    );
  }

  _waveView() {
    return [
      if (recordPath != null)
        WaveViewPlayAudio(
            recordPath: recordPath,
            wavePath: wavePath,
            trggelPlay: trggelPlay,
            isLocal: isLocal,
            isPlay: isPlay),
      if (errorStr != null)
        TextView(
          text: errorStr ?? '',
          padding: EdgeInsets.zero,
          sizeText: 14,
          colorText: AppColor.txtColor4,
          textAlign: TextAlign.start,
          // overflow: TextOverflow.ellipsis,
        ),
      if (small && actionReply != null)
        InkWell(
          onTap: () {
            actionReply!();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextView(
              text: 'رد',
              padding: EdgeInsets.zero,
              sizeText: 14,
              weightText: FontWeight.w700,
              colorText: AppColor.txtColor4,
              textAlign: TextAlign.start,

              // overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
    ];
  }

  Widget build2(BuildContext context) {
    var errorTypeActiv = _check(errorType) ?? ErrorType.errors[0];
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(6),
        margin: isReply
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
                    child: Image.asset(userImage ?? ''),
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
                                text: userName ?? '',
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
                          if (errorType != null && errorType!.isNotEmpty)
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: errorTypeActiv.color,
                              ),
                              child: TextView(
                                padding: EdgeInsets.zero,
                                text: 'نوع الخطاء : ' +
                                    (errorTypeActiv.value ?? 'تجويد'),
                                sizeText: 11,
                                colorText: AppColor.txtColor2,
                                textAlign: TextAlign.start,
                              ),
                            ),
                        ],
                      ),
                      if (ayah != null)
                        TextView(
                          padding: EdgeInsets.zero,
                          text: ayah ?? '',
                          sizeText: 18,
                          weightText: FontWeight.bold,
                          colorText:
                              isRead ? AppColor.txtColor3 : AppColor.txtColor4,
                          textAlign: TextAlign.start,
                          fontFamily: 'Hafs17',
                        ),
                      if (recordPath != null)
                        WaveViewPlayAudio(
                            recordPath: recordPath,
                            wavePath: wavePath,
                            trggelPlay: trggelPlay,
                            isLocal: isLocal,
                            isPlay: isPlay),
                      if (errorStr != null)
                        TextView(
                          text: errorStr ?? '',
                          padding: EdgeInsets.zero,
                          sizeText: 14,
                          colorText: AppColor.txtColor4,
                          textAlign: TextAlign.start,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      if (actionReply != null)
                        TextView(
                          text: 'رد',
                          padding: EdgeInsets.zero,
                          sizeText: 14,
                          weightText: FontWeight.w700,
                          colorText: AppColor.txtColor4,
                          textAlign: TextAlign.start,
                          action: () {
                            actionReply!();
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

  ErrorType? _check(String? errorType) {
    for (var element in ErrorType.errors) {
      if (errorType == element.key) {
        return element;
      }
    }
    return null;
  }
}
