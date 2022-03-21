import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagetap_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopupMessageDetails extends StatelessWidget {
  const PopupMessageDetails({
    Key? key, required this.msgId, required this.recitationId,

  }) : super(key: key);

  final int msgId;
  final int recitationId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageTapCubit, MessageTapState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit =MessageTapCubit.get(context);
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap:  () {
              cubit.markAsAccept(messageId: msgId, reciId: recitationId);

            },
            title:
             TextView(text: 'Mark as Accepted', textAlign: TextAlign.start,sizeText: 16, colorText: AppColor.txtColor3,),
            leading: Transform(

                alignment: Alignment.center,
                transform:
                isEn ?  Matrix4.rotationY(pi):Matrix4.rotationY(0),
                child:  Icon(Icons.check,size: 26,color:  AppColor.txtColor3)),
          ),
          ListTile(
            onTap:  () {
              cubit.markAsRemarkable(messageId: msgId, reciId: recitationId);
            },
            title:
             TextView(text: 'Mark as Remarkable', textAlign: TextAlign.start,sizeText: 16, colorText: AppColor.txtColor3,),
            leading: Transform(
                alignment: Alignment.center,
                transform:
                isEn ? Matrix4.rotationY(0) : Matrix4.rotationY(pi),
                child: Image.asset(AppIcons.quality2Icon,height: 26,color: AppColor.txtColor3,)),
          ),
        ],
      ),
    );
  },
);
  }
}