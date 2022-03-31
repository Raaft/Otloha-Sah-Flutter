import 'package:flutter/material.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_widget.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';

class UserMessageIetm extends StatelessWidget {
  const UserMessageIetm({
    Key? key,
    required this.userName,
    required this.userImage,
    required this.lastMsg,
    required this.lastDate,
    this.onPress,
    this.isRead = false,
  }) : super(key: key);

  final String userName;
  final String userImage;
  final String lastMsg;
  final String lastDate;
  final bool isRead;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      onPress: onPress,
      userImage: userImage,
      userName: _viwName(),
      dataView: _viewData(),
      ayahView: _viewAyah(),
      color: AppColor.selectColor1,
    );
  }

  Row _viewData() {
    return Row(
      children: [
        TextView(
          padding: EdgeInsets.zero,
          text: lastDate.toUpperCase(),
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
      text: lastMsg,
      sizeText: 18,
      weightText: FontWeight.w900,
      colorText: AppColor.headTextColor,
      textAlign: TextAlign.start,
      fontFamily: 'Hafs17',
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     color: AppColor.backItem,
  //     elevation: 0,
  //     margin: const EdgeInsets.all(4),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Row(
  //         children: [
  //           SizedBox(
  //             width: 60,
  //             height: 60,
  //             child: ClipRRect(
  //               borderRadius: const BorderRadius.all(Radius.circular(30)),
  //               child: Image.asset(userImage),
  //             ),
  //           ),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: [
  //                 TextView(
  //                   text: userName,
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
  //                   sizeText: 16,
  //                   weightText: FontWeight.bold,
  //                   textAlign: TextAlign.start,
  //                   colorText: AppColor.txtColor3,
  //                 ),
  //                 TextView(
  //                   text: lastMsg,
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
  //                   colorText: AppColor.txtColor4,
  //                   sizeText: 16,
  //                   textAlign: TextAlign.start,
  //                 ),
  //                 TextView(
  //                   text: lastDate,
  //                   padding: const EdgeInsets.symmetric(horizontal: 4),
  //                   colorText: AppColor.txtColor4,
  //                   sizeText: 16,
  //                   textAlign: TextAlign.end,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
