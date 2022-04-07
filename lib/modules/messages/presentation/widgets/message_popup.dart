import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/constant/constants.dart';
import '../../../../core/utils/res/icons_app.dart';

import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';
import '../../business_logic/cubit/messagetap_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class PopupMessageDetails extends StatelessWidget {
  const PopupMessageDetails({
    Key? key,
    required this.msgId,
    required this.recitationId,
  }) : super(key: key);

  final int msgId;
  final int recitationId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageTapCubit, MessageTapState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MessageTapCubit.get(context);

        return Container(
          color: AppColor.white,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  cubit.markAsAccept(messageId: msgId, reciId: recitationId);
                },
                title: TextView(
                  text: tr('Mark as Accepted'),
                  textAlign: TextAlign.start,
                  sizeText: 16,
                  colorText: AppColor.txtColor3,
                ),
                leading: Transform(
                    alignment: Alignment.center,
                    transform:
                        isEn ? Matrix4.rotationY(pi) : Matrix4.rotationY(0),
                    child:
                        Icon(Icons.check, size: 26, color: AppColor.txtColor3)),
              ),
              ListTile(
                onTap: () {
                  cubit.markAsRemarkable(
                      messageId: msgId, reciId: recitationId);
                },
                title: TextView(
                  text: tr('Mark as Remarkable'),
                  textAlign: TextAlign.start,
                  sizeText: 16,
                  colorText: AppColor.txtColor3,
                ),
                leading: Transform(
                    alignment: Alignment.center,
                    transform:
                        isEn ? Matrix4.rotationY(0) : Matrix4.rotationY(pi),
                    child: Image.asset(
                      AppIcons.quality2Icon,
                      height: 26,
                      color: AppColor.txtColor3,
                    )),
              ),
              ListTile(
                onTap: () {
                  cubit.sendMessageAsTeacher(
                    messageId: msgId,
                    reciId: recitationId,
                  );
                  Get.back();
                },
                title: TextView(
                  text: tr('send Message'),
                  textAlign: TextAlign.start,
                  sizeText: 16,
                  colorText: AppColor.txtColor3,
                ),
                leading: Transform(
                    alignment: Alignment.center,
                    transform:
                        isEn ? Matrix4.rotationY(0) : Matrix4.rotationY(pi),
                    child: Icon(
                      Icons.send,
                      color: AppColor.txtColor3,
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}
