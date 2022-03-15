import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/lib_edit/wave/just_waveform.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/box_message_item.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/wave_view.dart';
import 'package:rxdart/rxdart.dart';

class GeneralMessageItem extends StatefulWidget {
  const GeneralMessageItem({
    Key? key,
    required this.boxMessageItem,
    required this.progressStream,
    required this.isLike,
    required this.likeCount,
    this.liked,
    this.goLike,
    this.goNote,
    this.goReMraker,
    this.isPlay = false,
    this.viewBottom = false,
    required this.trggelPlay,
  }) : super(key: key);

  final BoxMessageItem boxMessageItem;

  final BehaviorSubject<WaveformProgress> progressStream;

  final bool isLike;
  final Function()? liked;
  final Function()? goLike;
  final Function()? goNote;
  final Function()? goReMraker;
  final int likeCount;

  final bool isPlay;
  final bool viewBottom;
  final Function() trggelPlay;

  @override
  State<GeneralMessageItem> createState() => _GeneralMessageItemState();
}

class _GeneralMessageItemState extends State<GeneralMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.boxMessageItem.isActive
            ? AppColor.selectColor1
            : AppColor.transparent,
      ),
      child: Column(
        children: [
          widget.boxMessageItem,
          WaveViewPlayAudio(
              progressStream: widget.progressStream,
              trggelPlay: widget.trggelPlay,
              isPlay: widget.isPlay),
          if (widget.viewBottom)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        child: Image.asset(
                          widget.isLike
                              ? AppIcons.like2Icon
                              : AppIcons.likeIcon,
                          color: widget.isLike
                              ? AppColor.darkBlue
                              : AppColor.txtColor4d,
                          width: 20,
                          height: 20,
                        ),
                        onTap: widget.liked,
                      ),
                      TextView(
                        text: widget.likeCount.toString(),
                        colorText: AppColor.txtColor4d,
                        sizeText: 20,
                        weightText: FontWeight.bold,
                        action: widget.goLike,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: widget.goNote,
                        child: Row(
                          children: [
                            Image.asset(
                              AppIcons.bubbleIcon,
                              color: AppColor.iconColor,
                              width: 20,
                              height: 20,
                            ),
                            TextView(
                              text: '20',
                              colorText: AppColor.txtColor4d,
                              sizeText: 20,
                              weightText: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        child: Row(
                          children: [
                            Image.asset(
                              AppIcons.quality2Icon,
                              color: AppColor.iconColor,
                              width: 20,
                              height: 20,
                            ),
                            TextView(
                              text: '20',
                              colorText: AppColor.txtColor4d,
                              sizeText: 20,
                              weightText: FontWeight.bold,
                            ),
                          ],
                        ),
                        onTap: widget.goReMraker,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: widget.goLike,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Stack(
                        children: [
                          Align(
                            alignment: const Alignment(-1, 0),
                            child: _circalUser(),
                          ),
                          Align(
                            alignment: const Alignment(-.62, 0),
                            child: _circalUser(),
                          ),
                          Align(
                            alignment: const Alignment(-.24, 0),
                            child: _circalUser(),
                          ),
                          Align(
                            alignment: const Alignment(.14, 0),
                            child: _circalUser(),
                          ),
                          Align(
                            alignment: const Alignment(.52, 0),
                            child: _circalUser(),
                          ),
                          Align(
                            alignment: const Alignment(.95, 0),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColor.gradient6,
                                    AppColor.gradient3
                                  ],
                                ),
                              ),
                              child: TextView(
                                text: '+9',
                                colorText: AppColor.txtColor2,
                                sizeText: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }

  SizedBox _circalUser() {
    return SizedBox(
      width: 20,
      height: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(AppImages.duserImage),
      ),
    );
  }
}
