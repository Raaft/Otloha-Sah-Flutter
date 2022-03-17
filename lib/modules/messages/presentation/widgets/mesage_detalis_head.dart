// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

import 'mesage_detalails_record.dart';

class MessageDetailsHead extends StatelessWidget {
  MessageDetailsHead({
    Key? key,
    required this.userName,
    required this.verText,
    required this.action,
    required this.typeView,
    required this.wavePath,
    required this.recordPath,
    this.isCertified = false,
  }) : super(key: key);

  bool typeView = true;
  final bool isCertified;

  final String? recordPath;
  final String? wavePath;
  final String userName;
  final String verText;

  final Function()? action;

  @override
  Widget build(BuildContext context) {
    final Widget view;

    view = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              /// crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _userImage(),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: userName,
                      weightText: FontWeight.bold,
                      padding: const EdgeInsets.all(2),
                      sizeText: 20,
                      colorText: AppColor.darkBlue,
                      textAlign: TextAlign.start,
                    ),
                    TextView(
                      text: 'سوره البقره الجزء الاول',
                      weightText: FontWeight.bold,
                      padding: const EdgeInsets.all(2),
                      sizeText: 12,
                      colorText: AppColor.txtColor4,
                    ),
                  ],
                ),
              ],
            ),
            TextView(
              text: '1/5/1997 may 12:12',
              weightText: FontWeight.bold,
              padding: const EdgeInsets.all(2),
              sizeText: 14,
              colorText: AppColor.txtColor4,
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextView(
            text: verText,
            padding: const EdgeInsets.all(2),
            sizeText: 14,
            colorText: AppColor.darkBlue,
            textAlign: TextAlign.center,
            // overflow: TextOverflow.ellipsis,
          ),
        ),
        MessageDetailsRecord(recordPath: recordPath, wavePath: wavePath),
      ],
    );

    return Card(
      elevation: 1,
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
      width: 60,
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(AppImages.duserImage),
      ),
    );
  }
}

class MessageDetailsReplay extends StatelessWidget {
  MessageDetailsReplay({
    Key? key,
    this.isCertified = false,
    required this.userName,
    required this.verText,
    this.recordPath,
    this.wavePath,
    required this.action,
  }) : super(key: key);

  bool typeView = true;
  final bool isCertified;

  final String userName;
  final String verText;

  final String? recordPath;
  final String? wavePath;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    final Widget view;
    view = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      text: 'Teacher',
                      weightText: FontWeight.bold,
                      padding: const EdgeInsets.all(2),
                      sizeText: 13,
                      colorText: AppColor.txtColor4,
                    ),
                  ],
                ),
              ],
            ),
            TextView(
              text: '1/5/1997 may 12:12',
              weightText: FontWeight.bold,
              padding: const EdgeInsets.all(2),
              sizeText: 14,
              colorText: AppColor.txtColor4,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.red.withOpacity(.3),
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
      width: 60,
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(AppImages.duserImage),
      ),
    );
  }
}
