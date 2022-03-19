import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_item_sub.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/wave_view.dart';

class GeneralMessageItem extends StatelessWidget {
  const GeneralMessageItem({
    Key? key,
    required this.boxMessageItem,
    required this.isLike,
    required this.likeCount,
    this.liked,
    this.goLike,
    this.goNote,
    this.goReMraker,
    this.isPlay = false,
    this.viewBottom = false,
    required this.isLocal,
    this.replay,
    this.margin = 12,
    required this.trggelPlay,
    required this.recordPath,
    required this.wavePath,
    this.commentCount = 0,
  }) : super(key: key);

  final SubMessageItem boxMessageItem;

  final bool isLike;
  final Function()? liked;
  final Function()? goLike;
  final Function()? goNote;
  final Function()? goReMraker;
  final int likeCount;
  final int commentCount;

  final bool isPlay;
  final bool isLocal;
  final double margin;
  final bool viewBottom;
  final Function() trggelPlay;
  final Widget? replay;

  final String? recordPath;
  final String? wavePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: boxMessageItem.action,
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: EdgeInsets.all(margin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.selectColor1,
        ),
        child: Column(
          children: [
            boxMessageItem,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: WaveViewPlayAudio(
                  recordPath: recordPath,
                  wavePath: wavePath,
                  trggelPlay: trggelPlay,
                  isLocal: isLocal,
                  isPlay: isPlay),
            ),
            if (viewBottom) _viewBottom(context),
            replay ?? Container(),
          ],
        ),
      ),
    );
  }

  Padding _viewBottom(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                GestureDetector(
                  child: Image.asset(
                    isLike ? AppIcons.like2Icon : AppIcons.likeIcon,
                    color: isLike ? AppColor.darkBlue : AppColor.txtColor4d,
                    width: 20,
                    height: 20,
                  ),
                  onTap: liked,
                ),
                TextView(
                  text: likeCount.toString(),
                  colorText: AppColor.txtColor4d,
                  sizeText: 16,
                  weightText: FontWeight.bold,
                  action: goLike,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                //const SizedBox(width: 8),
                GestureDetector(
                  onTap: goNote,
                  child: Row(
                    children: [
                      Image.asset(
                        AppIcons.bubbleIcon,
                        color: AppColor.iconColor,
                        width: 20,
                        height: 20,
                      ),
                      TextView(
                        text: commentCount.toString(),
                        colorText: AppColor.txtColor4d,
                        sizeText: 16,
                        weightText: FontWeight.bold,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(width: 8),
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
                        text: commentCount.toString(),
                        colorText: AppColor.txtColor4d,
                        sizeText: 16,
                        weightText: FontWeight.bold,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ],
                  ),
                  onTap: goReMraker,
                ),
              ],
            ),
          ),
          if (likeCount > 0)
            GestureDetector(
              onTap: goLike,
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
                            colors: [AppColor.gradient6, AppColor.gradient3],
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
