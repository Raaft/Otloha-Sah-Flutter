import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

class MessageDetailsHead extends StatelessWidget {
  MessageDetailsHead({
    Key? key,
    required this.userName,
    required this.verText,
    required this.action,
    required this.typeView,
    this.isCertified = false,
  }) : super(key: key);

  bool typeView = true;
  final bool isCertified;

  final String userName;
  final String verText;

  final Function()? action;

  @override
  Widget build(BuildContext context) {
    final Widget view;

    if (typeView) {
      view = Column(
        children: [
          Row(
            /// crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _userImage(),
              const SizedBox(width: 20),
              Column(
                children: [
                  TextView(
                    text: userName,
                    weightText: FontWeight.bold,
                    padding: const EdgeInsets.all(2),
                    sizeText: 18,
                    colorText: AppColor.darkBlue,
                  ),
                  TextView(
                    text: '1/5/1997',
                    weightText: FontWeight.bold,
                    padding: const EdgeInsets.all(2),
                    sizeText: 10,
                    colorText: AppColor.txtColor4,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.4),
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                  
                )),
            width: MediaQuery.of(context).size.width ,
            child: TextView(
              text: verText,
              padding: const EdgeInsets.all(2),
              sizeText: 14,
              colorText: AppColor.darkBlue,
              textAlign: TextAlign.center,
              // overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    } else {
      view = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _userImage(),
          TextView(
            text: userName,
            weightText: FontWeight.bold,
            padding: const EdgeInsets.all(2),
            sizeText: 18,
            colorText: AppColor.txtColor4,
          ),
          // const SizedBox(height: 4),
          TextView(
            text: verText,
            padding: const EdgeInsets.all(0),
            sizeText: 12,
            colorText: AppColor.txtColor4,
            weightText: FontWeight.w600,
            textAlign: TextAlign.start,
            //overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }

    return Card(
      elevation: 0,
    //  color: AppColor.backItem,
      child: GestureDetector(
        onTap: action,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: view,
        ),
      ),
    );
  }

  SizedBox _userImage() {
    return SizedBox(
      width: 50,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(AppImages.duserImage),
      ),
    );
  }

  List<Widget> _iconsView(double size) {
    return [
      Icon(
        Icons.star_border,
        color: AppColor.iconColor3,
        size: size,
      ),
      Icon(
        Icons.favorite_border,
        color: AppColor.iconColor,
        size: size,
      ),
      if (isCertified)
        Image.asset(
          AppIcons.qualityIcon,
          color: AppColor.iconColor5,
          width: size,
          height: size,
        ),
    ];
  }
}
