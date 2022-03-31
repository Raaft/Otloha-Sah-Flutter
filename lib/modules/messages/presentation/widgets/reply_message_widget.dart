import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagedetails_cubit.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/reply_cubit.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/reply_state.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/choose_error_type.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/selectable_message_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ReplayMessageWidget extends StatelessWidget {
  ReplayMessageWidget({
    Key? key,
    required this.recitationId,
    required this.msgId,
    this.parentId,
    this.ayahInfo,
    this.ayah,
    this.wave,
    this.record,
    this.reload,
    this.isATeacher = false,
  }) : super(key: key);

  final int recitationId;
  final int msgId;
  final int? parentId;
  final bool isATeacher;
  final String? ayahInfo;
  final String? ayah;
  final String? wave;
  final String? record;

  late ReplyCubit? replyCubit;
  final void Function()? reload;

  @override
  Widget build(BuildContext context) {
    replyCubit = ReplyCubit.get(context);

    return BlocConsumer<ReplyCubit, ReplyState>(
      listener: (context, state) {
        if (state is SavedState) {
          if (isATeacher && !replyCubit!.isRelpay) {
            Get.back();
          }
          reload!();
          replyCubit!.setViewMessage(false);
          replyCubit!.setIsReply(false);
          replyCubit!.setInit();
          BlocProvider.of<MessagedetailsCubit>(context)
              .setViewInput(false, null);
        }
        if (state is ChangeIsReply) {
          if (replyCubit!.isRelpay) {
            replyCubit!.setFoucs();
          }
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isATeacher && !replyCubit!.isRelpay) _viewMessage(),
            _messageField(state),
          ],
        );
      },
    );
  }

  _viewMessage() {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      duration: const Duration(microseconds: 5000),
      child: BlocConsumer<MessagedetailsCubit, MessagedetailsState>(
        listener: (context, state) {
          if (state is SavedState) {
            replyCubit!.setViewMessage(false);
            if (!isATeacher || replyCubit!.isRelpay) {
              BlocProvider.of<MessagedetailsCubit>(context)
                  .setViewInput(false, null);
            }
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: 'أضغط علي النص القرآني لتحديد موضع الخطأ',
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                sizeText: 14,
                colorText: AppColor.txtColor4,
                textAlign: TextAlign.start,
                // overflow: TextOverflow.ellipsis,
              ),
              SelectableMessageItem(
                ayah: ayah ?? 'dddd',
                wavePath: wave, recordPath: record,
                selectedText: (txt) {
                  String select =
                      ayah!.substring(txt.baseOffset, txt.extentOffset);

                  replyCubit!.setText(select);
                  print('Seleceted Text $select');
                },
                // overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }

  _messageField(state) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
      //padding: const EdgeInsets.all(4),
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
                      onTap: () {
                        if (!replyCubit!.viewMessage) {
                          replyCubit!.setViewMessage(true);
                        }
                      },
                      autofocus: true,
                      focusNode: replyCubit!.focusNode,
                      controller: replyCubit!.messageController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 1,
                    ),
                  ),
                  if (state is StartRecordingState)
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.stop_circle,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            replyCubit!.stop();
                          },
                        ),
                        TextView(text: state.time)
                      ],
                    ),
                  if (state is EndRecordingState ||
                      state is PlayerIsPlay ||
                      state is PlayerIsPause)
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            replyCubit!.delete();
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            (state is PlayerIsPlay)
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            if (state is PlayerIsPlay) {
                              replyCubit!.onPauseAudio();
                            } else {
                              replyCubit!.onPlayAudio();
                            }
                          },
                        ),
                      ],
                    ),
                  if (state is InitialReplyState ||
                      state is DeleteRecordState ||
                      state is ReplyStateDefult ||
                      state is ChangeIsReply ||
                      state is LoadingSaveState ||
                      state is DataChange)
                    IconButton(
                      icon: const Icon(
                        Icons.mic,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        replyCubit!.start();
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(
              15.0,
            ),
            decoration: const BoxDecoration(
                color: Colors.blueAccent, shape: BoxShape.circle),
            child: (state is LoadingSaveState)
                ? CircularProgressIndicator(
                    color: AppColor.white,
                  )
                : InkWell(
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onTap: (state is LoadingSaveState)
                        ? null
                        : () {
                            if (isATeacher && !replyCubit!.isRelpay) {
                              // Get.back();
                              Get.bottomSheet(
                                ChooseErrorType(
                                  choosed: (errorType) {
                                    Get.back();
                                    replyCubit!.saveRelpy(
                                        recitationId, msgId, parentId,
                                        errorType: errorType);
                                    Get.back();
                                    reload!();
                                    replyCubit!.setViewMessage(false);
                                    replyCubit!.setIsReply(false);
                                    replyCubit!.setInit();
                                  },
                                ),
                              );
                            } else {
                              replyCubit!
                                  .saveRelpy(recitationId, msgId, parentId);
                            }
                          },
                    onLongPress: () {},
                  ),
          ),
        ],
      ),
    );
  }
}
