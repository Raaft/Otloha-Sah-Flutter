import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/cached_image.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
    this.userImage,
    this.userName,
    this.dataView,
    this.ayahView,
    this.ayahInfoView,
    this.userInfo,
    this.waveView,
    this.footerView,
    this.small = false,
    this.onPress,
    this.onLongPress,
    required this.color,
    this.padding = const EdgeInsets.all(8),
    this.margin = const EdgeInsets.all(8),
  }) : super(key: key);

  final String? userImage;
  final Widget? userName;
  final Widget? dataView;
  final Widget? ayahView;
  final Widget? ayahInfoView;
  final Widget? userInfo;
  final Widget? waveView;
  final Widget? footerView;
  final bool small;
  final Function()? onPress;
  final Function()? onLongPress;
  final Color color;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        //main column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //row image and info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (userImage != null)
                  CachedImage(url: userImage ?? '', raduis: small ? 25 : 36),
                const SizedBox(width: 8),
                // column info
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // row name and date
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            userName ?? Container(),
                            const SizedBox(width: 8),
                            dataView ?? Container(),
                          ],
                        ),
                      ),
                      ayahView ?? Container(),
                      ayahInfoView ?? Container(),
                    ],
                  ),
                ),
              ],
            ),
            waveView ?? Container(),
            footerView ?? Container(),
          ],
        ),
      ),
    );
  }
}
