import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagedetails_cubit.dart';
import 'package:flutter_base/modules/messages/data/models/message_delails.dart';
import 'package:flutter_base/modules/messages/data/models/relpay.dart' as reply;
import 'package:flutter_base/modules/messages/presentation/widgets/comment_replay_item.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/mesage_detalails_record.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/mesage_detalis_head.dart';

import 'package:flutter_base/core/utils/themes/color.dart';

import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_popup.dart';
import 'package:get/get.dart';

class MessageDetails extends StatefulWidget {
  const MessageDetails(
      {Key? key, required this.msgId, required this.recitationId})
      : super(key: key);

  final int msgId;
  final int recitationId;

  @override
  State<MessageDetails> createState() => _MessageDetailsState();
}

class _MessageDetailsState extends State<MessageDetails> {
  MessagedetailsCubit? cubit;
  @override
  void initState() {
    super.initState();
    cubit = MessagedetailsCubit.get(context);
    cubit!.fetchMessages(widget.msgId, widget.recitationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _topView(context,
                msgId: widget.msgId, recitationId: widget.recitationId),
            /*=======_topView(context,)
            messageDetailsNew(context),
            _viewTitle(),
            _viewData()
>>>>>>> main */
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
        ),
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
      itemCount: cubit!.messageModel!.results![0].replies!.length,
      itemBuilder: (context, index) =>
          _viewItem(index, cubit!.messageModel!.results![0].replies![index]),
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
      actionIcon: IconButton(
          onPressed: () {
            Get.bottomSheet(PopupMessageDetails(
              msgId: msgId,
              recitationId: recitationId,
            ));
          },
          icon: Icon(Icons.more_vert)),
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
        ayahInfo: _getAyahInfo(cubit!.messageModel!.results![0].recitation),
        userImage:
            cubit!.messageModel!.results![0].recitation!.owner!.image ?? '',
        userName: _user(cubit!.messageModel!.results![0].recitation!.owner),
        userInfo: cubit!.messageModel!.results![0].recitation!.owner!.level! +
            ((cubit!.messageModel!.results![0].recitation!.owner!.isATeacher ??
                    false)
                ? 'Teacher'
                : 'Student'),
        dateStr: (cubit!.messageModel!.results![0].recitation!.finishedAt !=
                null)
            ? DateFormat('hh:mm dd MMM').format(DateTime.parse(
                cubit!.messageModel!.results![0].recitation!.finishedAt ?? ''))
            : null,
        color: AppColor.selectColor1,
        trggelPlay: () {},
        recordPath: cubit!.messageModel!.results![0].recitation!.record,
        wavePath: cubit!.messageModel!.results![0].recitation!.wave,
        isPlay: false,
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

  String _user1(reply.Owner? owner) {
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
    reply.Reply reply,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CommentReplayItem(
        isRead: false,
        ayah: reply.comment ?? '',
        ayahInfo: '',
        userImage: reply.owner!.image ?? '',
        userName: _user1(reply.owner),
        userInfo: cubit!.messageModel!.results![0].recitation!.owner!.level! +
            ((cubit!.messageModel!.results![0].recitation!.owner!.isATeacher ??
                    false)
                ? 'Teacher'
                : 'Student'),
        dateStr: (cubit!.messageModel!.results![0].recitation!.finishedAt !=
                null)
            ? DateFormat('hh:mm dd MMM').format(DateTime.parse(
                cubit!.messageModel!.results![0].recitation!.finishedAt ?? ''))
            : null,
        color: AppColor.selectColor1,
        isPlay: false,
        trggelPlay: () {},
        isReplay: false,
        recordPath: reply.record,
        wavePath: reply.wave,
        errorStr: reply.comment,
      ),
    );
  }
}
