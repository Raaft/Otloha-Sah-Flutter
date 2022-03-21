import 'package:flutter/material.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

import 'package:flutter_base/modules/messages/business_logic/cubit/messagedetails_cubit.dart';
import 'package:flutter_base/modules/messages/data/models/error_type.dart';
import 'package:flutter_base/modules/messages/data/models/message_delails.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/reply_cubit.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/reply_state.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/selectable_message_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReplayMesaagePage extends StatefulWidget {
  const ReplayMesaagePage({
    Key? key,
    required this.recitationId,
    required this.msgId,
    this.parentId,
  }) : super(key: key);

  final int recitationId;
  final int msgId;
  final int? parentId;

  @override
  State<ReplayMesaagePage> createState() => _ReplayMesaagePageState();
}

class _ReplayMesaagePageState extends State<ReplayMesaagePage> {
  MessagedetailsCubit? cubit;
  ReplyCubit? replyCubit;
  String? text;
  ErrorType? errorType;
  @override
  void initState() {
    super.initState();
    cubit = MessagedetailsCubit.get(context);
    replyCubit = ReplyCubit.get(context);
    cubit!.fetchMessages(widget.msgId, widget.recitationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _topView(context),
            messageDetailsNew(context),
            _textView(),
            _messageField(),
          ],
        ),
      ),
    );
  }

  messageDetailsNew(BuildContext context) {
    return BlocBuilder<MessagedetailsCubit, MessagedetailsState>(
      builder: (context, state) {
        if (state is MessageFetchedState) {
          replyCubit!.setAyah(cubit!.ayah);
          return _viewBody(cubit!.messageDetails);
        }
        if (state is MessageLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const ViewError(error: 'Not Found Data');
      },
    );
  }

  Widget _viewBody(MessageDelails? messageDetails) {
    return Column(
      children: [
        SelectableMessageItem(
          ayah: cubit!.ayah,
          ayahInfo: _getAyahInfo(messageDetails!.recitation),
          userImage: messageDetails.recitation!.owner!.image ?? '',
          userName: _user(messageDetails.recitation!.owner),
          dateStr: (cubit!.messageDetails!.recitation!.finishedAt != null)
              ? DateFormat('hh:mm dd MMM').format(DateTime.parse(
                  cubit!.messageDetails!.recitation!.finishedAt ?? ''))
              : null,
          color: AppColor.selectColor1, isRead: false, isCertic: false,
          selectedText: (txt) {
            String select = replyCubit!.ayahText!
                .substring(txt.baseOffset, txt.extentOffset);

            setState(() {
              text = select;
            });
            print('Seleceted Text $select');
          },
          userInfo: cubit!.messageDetails!.recitation!.owner!.level! +
              ' ' +
              ((cubit!.messageDetails!.recitation!.owner!.isATeacher ?? false)
                  ? translate('Teacher')
                  : translate('Student')),
          // overflow: TextOverflow.ellipsis,
        ),
      ],
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

  Widget _topView(BuildContext context) {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: translate('أضافة تعليق جديد'),
    );
  }

  _messageField() =>
      BlocConsumer<ReplyCubit, ReplyState>(listener: (context, state) {
        if (state is SavedState) {
          Get.back();
        }
      }, builder: (context, state) {
        ReplyCubit cubit = ReplyCubit.get(context);
        return Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.0),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 5,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cubit.messageController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          minLines: 1,
                        ),
                      ),
                      if (state is StartRecordingState)
                        IconButton(
                          icon: const Icon(
                            Icons.stop_circle,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            cubit.stop();
                          },
                        ),
                      if (state is EndRecordingState)
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                cubit.delete();
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                cubit.onPlayAudio();
                              },
                            ),
                          ],
                        ),
                      if (state is InitialReplyState ||
                          state is DeleteRecordState)
                        IconButton(
                          icon: const Icon(
                            Icons.mic,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            cubit.start();
                          },
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(
                    color: Colors.blueAccent, shape: BoxShape.circle),
                child: InkWell(
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onTap: () {
                    cubit.saveRelpy(widget.recitationId, widget.msgId,
                        widget.parentId, text ?? '');
                  },
                  onLongPress: () {},
                ),
              ),
            ],
          ),
        );
      });

  _textView() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: (replyCubit != null && replyCubit!.errorType != null)
                    ? (replyCubit!.errorType!.value ?? 'اختر نوع الخطأ')
                    : 'اختر نوع الخطأ',
                sizeText: 16,
                colorText: AppColor.txtColor4,
                textAlign: TextAlign.start,
              ),
              DropdownButton<ErrorType>(
                  underline: Container(
                    height: 0,
                  ),
                  // value: (replyCubit != null) ? replyCubit!.errorType : null,
                  items: ErrorType.errors.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: TextView(
                        text: e.value ?? '',
                        sizeText: 16,
                        colorText: AppColor.txtColor4,
                        textAlign: TextAlign.start,
                      ),
                    );
                  }).toList(),
                  onChanged: (errorType) {
                    setState(() {
                      this.errorType = errorType;
                    });
                    replyCubit!.setErrorType(errorType);
                  }),
            ],
          )
        ],
      ),
    );
  }
}
