import 'package:flutter/material.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_widget.dart';

import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';

class BoxMessageItem extends StatelessWidget {
  const BoxMessageItem({
    Key? key,
    required this.id,
    required this.userName,
    required this.userImage,
    required this.dateStr,
    required this.ayah,
    required this.ayahInfo,
    this.userInfo,
    this.color = AppColor.selectColor1,
    this.onPress,
    this.narrationName,
    this.isRead = false,
    this.onLongPress,
  }) : super(key: key);

  final int id;
  final String userName;
  final String userImage;
  final String? dateStr;
  final String? userInfo;
  final String? narrationName;
  final String ayah;
  final String ayahInfo;
  final Color color;
  final Function()? onPress;
  final Function()? onLongPress;

  final bool isRead;

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
      color: !isRead ? AppColor.transparent : AppColor.selectColor1,
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

  Widget _viwName() {
    TextView(
      text: userName,
      weightText: FontWeight.w900,
      padding: EdgeInsets.zero,
      sizeText: 10,
      letterSpacing: 0.4,
      colorText: AppColor.userNameColor,
    );

    return TextViewIcon(
      text: userName,
      weightText: FontWeight.w900,
      padding: EdgeInsets.zero,
      sizeText: 12,
      letterSpacing: 0.4,
      colorText: AppColor.userNameColor,
      icon: isRead
          ? Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                  colors: [AppColor.gradient1, AppColor.gradient2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            )
          : null,
    );
  }

  _viewAyah() {
    return TextView(
      padding: EdgeInsets.zero,
      text: ayah,
      sizeText: 18,
      weightText: FontWeight.w900,
      colorText: !isRead ? AppColor.txtColor4 : AppColor.headTextColor,
      textAlign: TextAlign.start,
      fontFamily: 'Hafs17',
    );
  }

  _ayahInfoView() {
    return TextView(
      padding: EdgeInsets.zero,
      text: (ayahInfo) + ' - رواية ' + (narrationName ?? 'حفص'),
      sizeText: 12,
      colorText: AppColor.userNameColor,
      textAlign: TextAlign.start,
    );
  }
}

// class ViewOld extends StatelessWidget {
//   const ViewOld({
//     Key? key,
//     required this.onPress,
//     required this.isActive,
//     required this.color,
//     required this.userImage,
//     required this.userName,
//     required this.dateStr,
//     required this.ayah,
//     required this.ayahInfo, this.narrationName, this.onLongPress,
//   }) : super(key: key);

//   final Function()? onPress;
//   final Function()? onLongPress;
//   final bool isActive;
//   final Color color;
//   final String userImage;
//   final String userName;
//   final String? dateStr;
//   final String ayah;
//   final String ayahInfo;
//   final String? narrationName;

//   @override
//   Widget build(BuildContext context) {
//      return MessageWidget(
//       onPress: onPress,
//       onLongPress: onLongPress,
//       userImage: userImage,
//       userName: _viwName(),
//       dataView: _viewData(),
//       ayahView: _viewAyah(),
//       ayahInfoView: _ayahInfoView(),
//     );
//   }

//   Row _viewData() {
//     return Row(
//       children: [
//         TextView(
//           padding: EdgeInsets.zero,
//           text: dateStr?.toUpperCase() ?? '',
//           sizeText: 10,
//           colorText: AppColor.txtColor4,
//         ),
//         const Icon(
//           Icons.bookmark_outline,
//           size: 12,
//           color: Colors.black,
//         )
//       ],
//     );
//   }

//   TextView _viwName() {
//     return TextView(
//       text: userName,
//       weightText: FontWeight.w900,
//       padding: EdgeInsets.zero,
//       sizeText: 10,
//       letterSpacing: 0.4,
//       colorText: AppColor.userNameColor,
//     );
//   }

//   _viewAyah() {
//     return TextView(
//       padding: EdgeInsets.zero,
//       text: ayah,
//       sizeText: 18,
//       weightText: FontWeight.w900,
//       colorText: AppColor.headTextColor,
//       textAlign: TextAlign.start,
//       fontFamily: 'Hafs17',
//     );
//   }

//   _ayahInfoView() {
//     return TextView(
//       padding: EdgeInsets.zero,
//       text: (ayahInfo) + ' - رواية ' + (narrationName ?? 'حفص'),
//       sizeText: 12,
//       colorText: AppColor.userNameColor,
//       textAlign: TextAlign.start,
//     );
//   }

//   //   return GestureDetector(
//   //     onTap: action,
//   //     child: Container(
//   //       margin: const EdgeInsets.all(4),
//   //       padding: const EdgeInsets.all(8),
//   //       decoration: BoxDecoration(
//   //         borderRadius: BorderRadius.circular(5),
//   //         color: isActive ? color : AppColor.transparent,
//   //       ),
//   //       child: Row(
//   //         children: [
//   //           CachedImage(
//   //             url: userImage,
//   //             raduis: 60,
//   //           ),
//   //           Expanded(
//   //             child: Column(
//   //               crossAxisAlignment: CrossAxisAlignment.stretch,
//   //               children: [
//   //                 Row(
//   //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                   children: [
//   //                     TextViewIcon(
//   //                       text: userName,
//   //                       weightText: FontWeight.w900,
//   //                       padding: const EdgeInsets.all(1),
//   //                       sizeText: 13,
//   //                       colorText: AppColor.txtColor4,
//   //                       icon: isActive
//   //                           ? Container(
//   //                               width: 8,
//   //                               height: 8,
//   //                               decoration: BoxDecoration(
//   //                                 borderRadius: BorderRadius.circular(4),
//   //                                 gradient: LinearGradient(
//   //                                   colors: [
//   //                                     AppColor.gradient1,
//   //                                     AppColor.gradient2
//   //                                   ],
//   //                                   begin: Alignment.topCenter,
//   //                                   end: Alignment.bottomCenter,
//   //                                 ),
//   //                               ),
//   //                             )
//   //                           : null,
//   //                     ),
//   //                     if (dateStr != null)
//   //                       Row(
//   //                         children: [
//   //                           TextView(
//   //                             padding: const EdgeInsets.all(1),
//   //                             text: dateStr ?? '',
//   //                             sizeText: 12,
//   //                             colorText: AppColor.txtColor4,
//   //                           ),
//   //                           Icon(
//   //                             Icons.bookmark_outline,
//   //                             size: 14,
//   //                             color: AppColor.txtColor4,
//   //                           )
//   //                         ],
//   //                       )
//   //                   ],
//   //                 ),
//   //                 TextView(
//   //                   padding: const EdgeInsets.all(1),
//   //                   text: ayah,
//   //                   sizeText: 20,
//   //                   weightText: FontWeight.w800,
//   //                   colorText:
//   //                       isActive ? AppColor.txtColor3 : AppColor.txtColor4,
//   //                   textAlign: TextAlign.end,
//   //                   fontFamily: 'Hafs17',
//   //                 ),
//   //                 TextView(
//   //                   padding: const EdgeInsets.all(1),
//   //                   text: ayahInfo,
//   //                   sizeText: 14,
//   //                   colorText: AppColor.txtColor4,
//   //                   textAlign: TextAlign.end,
//   //                 ),
//   //               ],
//   //             ),
//   //           )
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // 
// }
