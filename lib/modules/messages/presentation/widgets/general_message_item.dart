import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/data_source/cache_helper.dart';
import 'package:flutter_base/data_source/models/home_models/user_profile.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_widget.dart';
import 'package:flutter_base/modules/recitations/presentation/widget/popup_recitation.dart';

import 'package:flutter_base/modules/messages/presentation/widgets/wave_view.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';

class GeneralMessageItem extends StatelessWidget {
  const GeneralMessageItem({
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
  }) : super(key: key);

  // final MessageItemView? messageItemView;

  // final bool? isLike;
  // final Function()? liked;
  // final Function()? goLike;
  // final Function()? goNote;
  // final Function()? goReMraker;
  // final int? likeCount;
  // final int? commentCount;
  // final int? remarkableCount;
  // final double? margin;
  // final bool? viewBottom;

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

  onLongPress() {
    UserProfile user =
        UserProfile.fromJson(json.decode(CacheHelper.getData(key: profile)));
    print(CacheHelper.getData(key: profile));
    if ((user.id != ownerId) && user.isATeacher!) {
      Get.bottomSheet(
        PopupRecitation(
          actions: const [
            PopupActions.addToGeneral,
            PopupActions.delete,
            PopupActions.send,
            PopupActions.createMessge,
          ],
          isOwner: user.id == ownerId,
          finishedAt: dateStr ?? '',
          id: id ?? 0,
          isTeacher: user.isATeacher!,
          showInGeneral: true,
        ),
      );
    }
  }

/*
  InkWell(
      onTap: action,
    print('sdcs;dcml ${wavePath}');
    return InkWell(
      onTap: boxMessageItem.action,
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: EdgeInsets.all(margin ?? 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromARGB(51, 212, 248, 255),
        ),
        child: Column(
          children: [
            messageItemView ?? Container(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: WaveViewPlayAudio(
                recordPath: recordPath,
                wavePath: wavePath,
                trggelPlay: trggelPlay ?? () {},
                isLocal: isLocal ?? false,
                isPlay: isPlay ?? false,
              ),
            ),

            // if (viewBottom) _viewBottom(context),
            replay ?? Container(),
          ],
        ),
      ),
    );

 */
// Padding _viewBottom(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 4),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 4),
//           child: Row(
//             children: [
//               GestureDetector(
//                 child: Image.asset(
//                   AppIcons.like2Icon,
//                   // color: false ? AppColor.darkBlue : AppColor.txtColor4d,
//                   width: 20,
//                   height: 20,
//                 ),
//                 onTap: liked,
//               ),
//               TextView(
//                 text: (likeCount > 1) ? likeCount.toString() : '',
//                 colorText: AppColor.txtColor4d,
//                 sizeText: 16,
//                 weightText: FontWeight.bold,
//                 action: goLike,
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//               ),
//               //const SizedBox(width: 8),
//               GestureDetector(
//                 onTap: goNote,
//                 child: Row(
//                   children: [
//                     Image.asset(
//                       AppIcons.bubbleIcon,
//                       color: AppColor.iconColor,
//                       width: 20,
//                       height: 20,
//                     ),
//                     TextView(
//                       text: (commentCount > 1) ? commentCount.toString() : '',
//                       colorText: AppColor.txtColor4d,
//                       sizeText: 16,
//                       weightText: FontWeight.bold,
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                     ),
//                   ],
//                 ),
//               ),
//               // const SizedBox(width: 8),
//               GestureDetector(
//                 child: Row(
//                   children: [
//                     Image.asset(
//                       AppIcons.quality2Icon,
//                       color: AppColor.iconColor,
//                       width: 20,
//                       height: 20,
//                     ),
//                     TextView(
//                       text: (remarkableCount > 1)
//                           ? remarkableCount.toString()
//                           : '',
//                       colorText: AppColor.txtColor4d,
//                       sizeText: 16,
//                       weightText: FontWeight.bold,
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                     ),
//                   ],
//                 ),
//                 onTap: goReMraker,
//               ),
//             ],
//           ),
//         ),
//         if (likeCount > 0)
//           GestureDetector(
//             onTap: goLike,
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width * .25,
//               child: Stack(
//                 children: [
//                   Align(
//                     alignment: const Alignment(-1, 0),
//                     child: _circalUser(),
//                   ),
//                   Align(
//                     alignment: const Alignment(-.62, 0),
//                     child: _circalUser(),
//                   ),
//                   Align(
//                     alignment: const Alignment(-.24, 0),
//                     child: _circalUser(),
//                   ),
//                   Align(
//                     alignment: const Alignment(.14, 0),
//                     child: _circalUser(),
//                   ),
//                   Align(
//                     alignment: const Alignment(.52, 0),
//                     child: _circalUser(),
//                   ),
//                   Align(
//                     alignment: const Alignment(.95, 0),
//                     child: Container(
//                       width: 20,
//                       height: 20,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         gradient: LinearGradient(
//                           colors: [AppColor.gradient6, AppColor.gradient3],
//                         ),
//                       ),
//                       child: TextView(
//                         text: '+9',
//                         colorText: AppColor.txtColor2,
//                         sizeText: 10,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//       ],
//     ),
//   );
// }

// SizedBox _circalUser() {
//   return SizedBox(
//     width: 20,
//     height: 20,
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: Image.asset(AppImages.duserImage),
//     ),
//   );
// }

}
