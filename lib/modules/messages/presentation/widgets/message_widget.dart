import 'package:flutter/material.dart';
import 'package:flutter_base/core/widgets/cached_image.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
    this.userImage,
    this.userName,
    this.dataView,
    this.ayahView,
    this.ayahInfoView,
    this.waveView,
    this.footerView,
  }) : super(key: key);

  final String? userImage;
  final Widget? userName;
  final Widget? dataView;
  final Widget? ayahView;
  final Widget? ayahInfoView;
  final Widget? waveView;
  final Widget? footerView;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(51, 212, 248, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedImage(url: userImage ?? '', raduis: 36),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        userName ?? Container(),
                        dataView ?? Container(),
                      ],
                    ),
                  ),
                  ayahView ?? Container(),
                  ayahInfoView ?? Container(),
                  waveView ?? Container(),
                  footerView ?? Container(),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
