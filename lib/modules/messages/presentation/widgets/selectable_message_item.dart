import 'package:flutter/material.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_widget.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/wave_view.dart';

import '../../../../core/utils/res/icons_app.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/utils/themes/text_style.dart';
import '../../../../core/widgets/text_view.dart';

class SelectableMessageItem extends StatelessWidget {
  const SelectableMessageItem({
    Key? key,
    this.userName,
    this.userImage,
    this.dateStr,
    required this.ayah,
    this.ayahInfo,
    this.color,
    this.action,
    this.userInfo,
    this.narrationName,
    this.isRead,
    this.isCertic,
    this.selectedText,
    this.isPlay,
    this.isLocal,
    this.trggelPlay,
    this.replay,
    this.recordPath,
    this.wavePath,
  }) : super(key: key);

  final String? userName;
  final String? userImage;
  final String? dateStr;
  final String ayah;
  final String? ayahInfo;
  final Color? color;
  final Function()? action;
  final Function(TextSelection)? selectedText;

  final String? userInfo;
  final String? narrationName;
  final bool? isRead;
  final bool? isCertic;

  final bool? isPlay;
  final bool? isLocal;
  final Function()? trggelPlay;
  final Widget? replay;

  final String? recordPath;
  final String? wavePath;

  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      margin: EdgeInsets.zero,
      ayahView: _viewAyah(),
      ayahInfoView: _waveView(),
      color: AppColor.selectColor1,
    );
  }

  _waveView() {
    return WaveViewPlayAudio(
      recordPath: recordPath,
      wavePath: wavePath,
      trggelPlay: trggelPlay ?? () {},
      isLocal: isLocal ?? false,
      isPlay: isPlay ?? false,
    );
  }

  _viewAyah() {
    return SelectableText(
      ayah,
      textAlign: TextAlign.start,
      showCursor: true,
      cursorRadius: const Radius.circular(16),
      cursorWidth: 1,
      onSelectionChanged: sele,
      toolbarOptions: const ToolbarOptions(copy: false, selectAll: false),
      style: AppStyle().textStyle1.copyWith(
            fontSize: 20,
            color: AppColor.headTextColor,
            fontWeight: FontWeight.bold,
            wordSpacing: .5,
            fontFamily: 'Hafs17',
          ),
    );
  }

  Widget build2(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: (isRead ?? false) ? color : AppColor.transparent,
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
                    child: Image.asset(userImage ?? ''),
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
                                text: userName ?? '',
                                weightText: FontWeight.w900,
                                padding: EdgeInsets.zero,
                                sizeText: 12,
                                colorText: AppColor.txtColor4,
                                icon: (isRead ?? false)
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
                              if (isRead ?? false)
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
                          if (isRead ?? false)
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
                              color: AppColor.headTextColor,
                              fontWeight: FontWeight.bold,
                              wordSpacing: .5,
                              fontFamily: 'Hafs17',
                            ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextView(
                          padding: EdgeInsets.zero,
                          text: (ayahInfo ?? '') +
                              ' - رواية ' +
                              (narrationName ?? 'حفص'),
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
    selectedText!(selection);
  }
}
