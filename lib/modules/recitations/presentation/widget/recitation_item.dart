import 'package:flutter/material.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/wave_view.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_widget.dart';

class RecitationItem extends StatelessWidget {
  const RecitationItem({
    Key? key,
    this.isPlay,
    this.isLocal,
    this.trggelPlay,
    this.replay,
    this.recordPath,
    this.wavePath,
    this.userImage,
    this.id,
    this.ownerId,
    this.userName,
    this.dateStr,
    this.ayah,
    this.ayahInfo,
    this.color,
    this.onPress,
    this.userInfo,
    this.narrationName,
    this.isRead,
    this.isCertic,
    this.hasMenu,
    this.onLongPress,
  }) : super(key: key);

  final bool? isPlay;
  final bool? isLocal;
  final Function()? trggelPlay;
  final Widget? replay;

  final String? recordPath;
  final String? wavePath;
  final String? userImage;

  final int? id;
  final int? ownerId;
  final String? userName;
  final String? dateStr;
  final String? ayah;
  final String? ayahInfo;
  final Color? color;
  final Function()? onPress;
  final Function()? onLongPress;

  final String? userInfo;
  final String? narrationName;
  final bool? isRead;
  final bool? isCertic;
  final bool? hasMenu;

  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      onPress: onPress,
      onLongPress: onLongPress,
      userImage: userImage,
      userName: _viwName(),
      dataView: _viewData(),
      ayahView: _viewAyah(),
      ayahInfoView: _ayahInfoView(),
      waveView: _waveView(),
      color: AppColor.selectColor1,
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

  _viewAyah() {
    return TextView(
      padding: EdgeInsets.zero,
      text: ayah ?? '',
      sizeText: 18,
      weightText: FontWeight.w900,
      colorText: AppColor.headTextColor,
      textAlign: TextAlign.start,
      fontFamily: 'Hafs17',
    );
  }

  _ayahInfoView() {
    return TextView(
      padding: EdgeInsets.zero,
      text: (ayahInfo ?? '') + ' - رواية ' + (narrationName ?? 'حفص'),
      sizeText: 12,
      colorText: AppColor.userNameColor,
      textAlign: TextAlign.start,
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
}
