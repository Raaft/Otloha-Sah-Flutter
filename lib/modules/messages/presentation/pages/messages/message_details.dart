import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagedetails_cubit.dart';
import 'package:flutter_base/modules/messages/data/models/message_delails.dart';
import 'package:flutter_base/modules/messages/presentation/pages/messages/replay_message_page.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/comment_replay_item.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/mesage_detalails_record.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/mesage_detalis_head.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_popup.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:quran_widget_flutter/helper/chash_helper.dart';

import '../../../../../data_source/models/home_models/user_prfile.dart';

class MessageDetailsPage extends StatefulWidget {
  const MessageDetailsPage(
      {Key? key, required this.msgId, required this.recitationId})
      : super(key: key);

  final int msgId;
  final int recitationId;

  @override
  State<MessageDetailsPage> createState() => _MessageDetailsPageState();
}

class _MessageDetailsPageState extends State<MessageDetailsPage> {
  MessagedetailsCubit? cubit;
  late UserProfile userProfile;

  Future<void> init() async {
    userProfile = UserProfile.fromJson(
        jsonDecode(await CacheHelper.getData(key: profile)));
    cubit = MessagedetailsCubit.get(context);
    cubit!.fetchMessages(widget.msgId, widget.recitationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: init(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? Column(
                      children: [
                        _topView(context,
                            msgId: widget.msgId,
                            recitationId: widget.recitationId),
                        BlocBuilder<MessagedetailsCubit, MessagedetailsState>(
                          builder: (context, state) {
                            if (state is MessageFetchedState) {
                              return _viewBody(context);
                            }
                            if (state is MessageLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return const ViewError(error: 'Not Found Data');
                          },
                        ),
                      ],
                    )
                  : const SizedBox();
            }),
      ),
    );
  }

  Expanded _viewBody(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [messageDetailsNew(context), _viewTitle(), _viewData()],
      ),
    );
  }

  ListView _viewData() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cubit!.messageDetails!.replies!.length,
      itemBuilder: (context, index) =>
          _viewItem(index, cubit!.messageDetails!.replies![index]),
    );
  }

  Widget _viewTitle() {
    return SizedBox(
      width: double.infinity,
      child: TextView(
        text: 'التعليقات ...',
        weightText: FontWeight.bold,
        padding: const EdgeInsets.all(16),
        sizeText: 15,
        textAlign: TextAlign.start,
        colorText: AppColor.darkBlue,
      ),
    );
  }

  Widget _topView(BuildContext ctx,
      {required int msgId, required int recitationId}) {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(ctx).pop();
        },
      ),
      title: translate('تفاصيل الرسالة'),
      actionIcon: userProfile.isATeacher ?? false
          ? IconButton(
              onPressed: () {
                Get.bottomSheet(PopupMessageDetails(
                  msgId: msgId,
                  recitationId: widget.recitationId,
                ));
              },
              icon: const Icon(Icons.more_vert),
            )
          : const SizedBox(),
    );
  }

  Widget messageReplay() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(),
      MessageDetailsReplay(
        userName: 'Shady',
        verText: 'Text of messageText of messageT',
        action: () {},
        isCertified: true,
      ),
      const MessageDetailsRecord(
        recordPath: '',
        wavePath: '',
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextView(
            text: 'Comment',
            padding: const EdgeInsets.all(0),
            sizeText: 16,
            colorText: AppColor.txtColor4,
            weightText: FontWeight.w600,
            textAlign: TextAlign.center,
            //overflow: TextOverflow.ellipsis,
          ),
          TextView(
            text: 'Add Replay',
            padding: const EdgeInsets.all(0),
            sizeText: 15,
            colorText: AppColor.darkBlue,
            weightText: FontWeight.w600,
            textAlign: TextAlign.center,
            action: () {},
            //overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ]);
  }

  messageDetailsNew(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: CommentReplayItem(
        isLocal: false,
        isRead: false,
        ayah: cubit!.ayah,
        ayahInfo: _getAyahInfo(cubit!.messageDetails!.recitation),
        userImage: cubit!.messageDetails!.recitation!.owner!.image,
        userName: _user(cubit!.messageDetails!.recitation!.owner),
        userInfo: cubit!.messageDetails!.recitation!.owner!.level! +
            ((cubit!.messageDetails!.recitation!.owner!.isATeacher ?? false)
                ? 'Teacher'
                : 'Student'),
        dateStr: (cubit!.messageDetails!.recitation!.finishedAt != null)
            ? DateFormat('hh:mm dd MMM').format(DateTime.parse(
                cubit!.messageDetails!.recitation!.finishedAt ?? ''))
            : null,
        color: AppColor.selectColor1,
        trggelPlay: () {},
        recordPath: cubit!.messageDetails!.recitation!.record,
        wavePath: cubit!.messageDetails!.recitation!.wave,
        isPlay: false,
        errorType: null,
        actionReply: () {
          Get.to(
            ReplayMesaagePage(
              msgId: widget.msgId,
              recitationId: widget.recitationId,
              //  parentId: reply.parent,
            ),
          )!
              .then((value) {
            cubit!.fetchMessages(widget.msgId, widget.recitationId);
          });
        },
      ),
    );
  }

  String _getAyahInfo(Recitation? recitation) {
    String? str =
        'سورة ${recitation!.chapterId ?? 0} من آية ${recitation.verseIds![0]} الي آية ${recitation.verseIds![recitation.verseIds!.length - 1]}';
    return str;
  }

  String _user(Owner? owner) {
    if (owner != null) {
      var str = (owner.lastName!.isEmpty && owner.firstName!.isEmpty)
          ? (owner.username)
          : '';
      return (owner.firstName ?? '') +
          ' ' +
          (owner.lastName ?? '') +
          (str ?? '');
    } else {
      return '';
    }
  }

  String _user1(Owner? owner) {
    if (owner != null) {
      var str = (owner.lastName!.isEmpty && owner.firstName!.isEmpty)
          ? (owner.username)
          : '';
      return (owner.firstName ?? '') +
          ' ' +
          (owner.lastName ?? '') +
          (str ?? '');
    } else {
      return '';
    }
  }

  _viewItem(
    int index,
    Replies reply,
  ) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        CommentReplayItem(
          isRead: false,
          ayah: reply.text,
          userImage: reply.owner!.image,
          userName: _user1(reply.owner),
          userInfo: cubit!.messageDetails!.recitation!.owner!.level! +
              ((cubit!.messageDetails!.recitation!.owner!.isATeacher ?? false)
                  ? ' Teacher'
                  : ' Student'),
          dateStr: (cubit!.messageDetails!.recitation!.finishedAt != null)
              ? DateFormat('hh:mm dd MMM').format(DateTime.parse(
                  cubit!.messageDetails!.recitation!.finishedAt ?? ''))
              : null,
          color: AppColor.selectColor1,
          isPlay: false,
          trggelPlay: () {},
          isReplay: (reply.parent != null && (reply.parent ?? 0) > 0),
          recordPath: reply.record,
          wavePath: reply.wave,
          errorStr: reply.comment,
          errorType: reply.errorType,
          actionReply: () {
            Get.to(
              ReplayMesaagePage(
                msgId: widget.msgId,
                recitationId: widget.recitationId,
                parentId: (reply.parent != null) ? reply.parent : reply.id,
              ),
            )!
                .then((value) {
              cubit!.fetchMessages(widget.msgId, widget.recitationId);
            });
          },
        ),
        if (reply.children!.isNotEmpty) _viewDataCh(reply.children),
      ],
    );
  }

  ListView _viewDataCh(List<Replies>? children) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: children!.length,
      itemBuilder: (context, index) => _viewItem(index, children[index]),
    );
  }
}
