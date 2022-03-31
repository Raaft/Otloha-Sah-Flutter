// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_base/core/pagination/view/pagination_view.dart';
import 'package:flutter_base/data_source/models/message_model/message_model.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagesend_cubit.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/box_message_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/exception_indicators/error_indicator.dart';
import '../messages/message_details.dart';

class OutBoxMessagePage extends StatelessWidget {
  OutBoxMessagePage({Key? key}) : super(key: key);

  late MessagesendCubit? cubit;

  @override
  Widget build(BuildContext context) {
    cubit = MessagesendCubit.get(context);
    return Expanded(
      child: BlocBuilder<MessagesendCubit, MessagesendState>(
        builder: (context, state) {
          if (state is MessageSendSuccessLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MessageSendErrorState) {
            return ErrorIndicator(error: state.error);
          }
          if (state is MessageSendSuccessState) {
            return _showData(cubit);
          }

          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _showData(MessagesendCubit? cubit) {
    print(cubit!.messageSendList!.toString() +
        ' ' +
        cubit.messageSendList!.first.recitation!.name.toString());
    return PaginationData<MessageModel>(
      getData: (nextLink) async {
        return await cubit.getNextSendData(nextLink);
      },
      drowItem: (results, index) {
        _getItem(index, results);
      },
      initData: cubit.messageSendList!,
    );
  }

  Widget _showData2(MessagesendCubit? cubit) {
    print(cubit!.messageSendList!.toString() +
        ' ' +
        cubit.messageSendList!.first.recitation!.name.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: cubit.messageSendList!.length,
        itemBuilder: (context, index) {
          return _getItem(index, cubit.messageSendList![index]);
        },
      ),
    );
  }

  Widget _getItem(int index, MessageModel messageModel) {
    return BoxMessageItem(
      id: messageModel.id!,
      isRead: messageModel.isRead ?? false,
      ayah: messageModel.recitation!.name ?? '',
      ayahInfo: _getAyahInfo(messageModel.recitation),
      narrationName: messageModel.recitation!.narrationId.toString(),
      userImage: messageModel.addressee!.image ?? '',
      userName:
          '${messageModel.addressee!.firstName} ${messageModel.addressee!.lastName}',
      userInfo: messageModel.addressee!.level! +
          ((messageModel.addressee!.isATeacher ?? false)
              ? 'Teacher'
              : 'Student'),
      dateStr: (messageModel.recitation!.finishedAt != null)
          ? DateFormat('hh:mm dd MMM')
              .format(DateTime.parse(messageModel.recitation!.finishedAt ?? ''))
          : null,
      onPress: () {
        print(messageModel.id.toString() +
            ' ' +
            messageModel.recitation!.id.toString());
        Get.to(() => MessageDetailsPage(
              msgId: messageModel.id ?? 0,
              recitationId: messageModel.recitation!.id!,
            ));
      },
    );
  }

  String _getAyahInfo(Recitation? recitation) {
    String? str =
        'سورة ${recitation!.chapterName ?? 0} من آية ${recitation.verseIds![0]} الي آية ${recitation.verseIds![recitation.verseIds!.length - 1]}';
    return str;
  }
}
