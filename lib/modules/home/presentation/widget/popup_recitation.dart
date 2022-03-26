import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/data/model/recitations.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/popup_action_cubit.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/popup_actions_state.dart';
import 'package:flutter_base/modules/home/presentation/widget/popup_chose_teacher_send.dart';
import 'package:flutter_base/modules/messages/presentation/pages/messages/message_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

enum PopupActions {
  markAsFinished,
  addToGeneral,
  delete,
  send,
  createMessge,
}

class PopupRecitation extends StatelessWidget {
  const PopupRecitation({
    Key? key,
    required this.isOwner,
    required this.isTeacher,
    required this.actions,
    required this.id,
    required this.finishedAt,
    this.canCreateMessage,
    this.delete,
    this.showInGeneral,
  }) : super(key: key);

  final int id;
  final String finishedAt;
  final bool isTeacher;
  final bool isOwner;
  final bool? showInGeneral;
  final bool? canCreateMessage;

  final List<PopupActions> actions;
  final Function? delete;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<PopupActionsCubit>(context);
    cubit.setShared(showInGeneral ?? false);
    return BlocConsumer<PopupActionsCubit, PopupActionsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28), topRight: Radius.circular(28)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (actions.contains(PopupActions.markAsFinished) &&
                  finishedAt.isEmpty)
                ListTile(
                  onTap: () => cubit.markAsFinished(id),
                  title: TextView(
                    text: translate('MarkAsFinish'),
                    textAlign: TextAlign.start,
                    colorText: AppColor.headTextColor,
                  ),
                  leading: const Icon(Icons.mark_chat_read),
                ),
              if (actions.contains(PopupActions.addToGeneral) &&
                  finishedAt.isNotEmpty &&
                  isOwner)
                ListTile(
                  onTap: () {
                    cubit.addToGeneral(id);
                  },
                  title: TextView(
                    text: cubit.isShared
                        ? translate('RemoveFromGeneral')
                        : translate('AddToGeneral'),
                    textAlign: TextAlign.start,
                    colorText: AppColor.headTextColor,
                  ),
                  leading: Icon(
                    Icons.share,
                    color: AppColor.headTextColor,
                  ),
                  trailing: cubit.isShared
                      ? Icon(
                          Icons.check,
                          color: AppColor.headTextColor,
                        )
                      : const SizedBox(),
                ),
              if (actions.contains(PopupActions.send) && isOwner)
                ListTile(
                  onTap: () {
                    print(id);
                    Get.bottomSheet(
                      PopupChooseTeacherSend(
                        id: id,
                      ),
                    );
                  },
                  title: TextView(
                    text: translate('SendTo'),
                    textAlign: TextAlign.start,
                    colorText: AppColor.headTextColor,
                  ),
                  leading: Transform(
                    alignment: Alignment.center,
                    transform:
                        isEn ? Matrix4.rotationY(0) : Matrix4.rotationY(pi),
                    child: Icon(
                      Icons.send,
                      color: AppColor.headTextColor,
                    ),
                  ),
                ),
              if (actions.contains(PopupActions.delete) && isOwner)
                ListTile(
                  onTap: () async {
                    await cubit.deleteRecitations(id);
                    delete!();
                  },
                  title: TextView(
                      text: translate('Delete'),
                      colorText: AppColor.txtColor5,
                      textAlign: TextAlign.start),
                  leading: Icon(
                    Icons.delete,
                    color: AppColor.txtColor5,
                  ),
                ),
              if (isTeacher && actions.contains(PopupActions.createMessge))
                ListTile(
                  onTap: () async {
                    int msgId = await cubit.createMessage(id);
                    Get.to(MessageDetailsPage(
                      msgId: msgId,
                      recitationId: id,
                    ));
                  },
                  title: Text(translate('CreateMessage')),
                  leading: const Icon(Icons.message),
                ),
            ],
          ),
        );
      },
    );
  }
}
