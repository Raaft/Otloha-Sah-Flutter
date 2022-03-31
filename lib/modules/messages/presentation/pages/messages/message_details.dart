import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/widgets/cached_image.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/reply_message_widget.dart';
import '../../../../../core/utils/constant/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/themes/color.dart';
import '../../../../../core/widgets/text_view.dart';
import '../../../../../core/widgets/tool_bar_app.dart';
import '../../../business_logic/cubit/messagedetails_cubit.dart';
import '../old/replay_message_page.dart';
import '../../widgets/comment_replay_item.dart';
import '../../widgets/mesage_detalails_record.dart';
import '../../widgets/mesage_detalis_head.dart';
import '../../widgets/message_popup.dart';
import '../../../../settings/presentation/widgets/view_error.dart';
import 'package:quran_widget_flutter/helper/chash_helper.dart';

import '../../../../../data_source/models/home_models/user_profile.dart';
import '../../../../../data_source/models/message_model/message_delails.dart';

class MessageDetailsPage extends StatelessWidget {
  final int msgId;
  final int recitationId;
  final String? userImage;
  final String? userName;

  MessagedetailsCubit? cubit;
  late UserProfile userProfile;

  MessageDetailsPage({
    Key? key,
    required this.msgId,
    required this.recitationId,
    this.userImage,
    this.userName,
  }) : super(key: key);

  Future<void> init(context) async {
    userProfile = UserProfile.fromJson(
        jsonDecode(await CacheHelper.getData(key: profile)));
    print('user profile $userProfile');
    cubit = MessagedetailsCubit.get(context);
    cubit!.fetchMessages(msgId, recitationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: init(context),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? BlocBuilder<MessagedetailsCubit, MessagedetailsState>(
                      builder: (context, state) {
                        if (state is MessageFetchedState ||
                            state is MessageEmptyState) {
                          return Column(
                            children: [
                              _topView(context,
                                  msgId: msgId, recitationId: recitationId),
                              _viewBody(context),
                              if ((myProFile?.isATeacher ?? false) ||
                                  cubit!.isViewInput)
                                _viewInputRelpy(),
                            ],
                          );
                        }

                        if (state is MessageLoadingState) {
                          return const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return const ViewError(error: 'Not Found Data');
                      },
                    )
                  : const SizedBox();
            }),
      ),
    );
  }

  _viewInputRelpy() {
    return ReplayMessageWidget(
      recitationId: recitationId,
      msgId: msgId,
      record: cubit!.messageDetails!.recitation!.record,
      wave: cubit!.messageDetails!.recitation!.wave,
      ayah: cubit!.ayah,
      ayahInfo: _getAyahInfo(cubit!.messageDetails!.recitation),
      reload: () {
        cubit!.fetchMessages(msgId, recitationId);
      },
      isAyah: (myProFile?.isATeacher ?? false),
      parentId: cubit!.parentId,
    );
  }

  Expanded _viewBody(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [_messageDetails(context), _viewTitle(), _viewData()],
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
      titleWidget: Row(
        children: [
          CachedImage(url: userProfile.image ?? '', raduis: 24),
          const SizedBox(width: 8),
          TextView(
            text: _user3(userProfile),
            weightText: FontWeight.w900,
            padding: EdgeInsets.zero,
            sizeText: 18,
            letterSpacing: 0.4,
            colorText: AppColor.userNameColor,
          ),
        ],
      ),
      actionIcon: userProfile.isATeacher ?? false
          ? IconButton(
              onPressed: () {
                Get.bottomSheet(PopupMessageDetails(
                  msgId: msgId,
                  recitationId: recitationId,
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

  _messageDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: CommentReplayItem(
        isLocal: false,
        isRead: false,
        ayah: cubit!.ayah,
        ayahInfo: _getAyahInfo(cubit!.messageDetails!.recitation),
        userImage: cubit!.messageDetails!.recitation!.owner!.image,
        userName: _user(cubit!.messageDetails!.recitation!.owner),
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
      //padding: const EdgeInsets.symmetric(vertical: 8.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        CommentReplayItem(
          isRead: false,
          small: true,
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
          isReply: (reply.parent != null && (reply.parent ?? 0) > 0),
          recordPath: reply.record,
          wavePath: reply.wave,
          errorStr: reply.comment,
          errorType: reply.errorType,
          actionReply: () {
            int? parent = (reply.parent != null) ? reply.parent : reply.id;
            print(parent);
            cubit!.setViewInput(true, parent);
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

  _user3(UserProfile userProfile) {
    if (userProfile != null) {
      var str =
          (userProfile.lastName!.isEmpty && userProfile.firstName!.isEmpty)
              ? (userProfile.username)
              : '';
      return (userProfile.firstName ?? '') +
          ' ' +
          (userProfile.lastName ?? '') +
          (str ?? '');
    } else {
      return '';
    }
  }
}
