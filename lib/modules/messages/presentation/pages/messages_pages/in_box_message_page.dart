// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagetap_cubit.dart';
import 'package:flutter_base/modules/messages/data/models/MessageModel.dart';
import 'package:flutter_base/modules/messages/presentation/pages/messages/message_details.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/box_message_item.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InBoxMessagePage extends StatelessWidget {
  InBoxMessagePage({Key? key}) : super(key: key);

  late MessageTapCubit? cubit;

  @override
  Widget build(BuildContext context) {
    cubit = MessageTapCubit.get(context);
    return BlocBuilder<MessageTapCubit, MessageTapState>(
      builder: (context, state) {
        if (state is NoAuthState) {
          Future.delayed(const Duration(seconds: 1), () {
            print('object');
            Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
          });
        }
        if (state is MessageRecieveSuccessLoadingState) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is MessageRecieveSuccessState) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: cubit!.messageSendList!.length,
                itemBuilder: (context, index) {
                  return _getItem(index, cubit!.messageRecieve![index]);
                },
              ),
            ),
          );
        }
        return const Expanded(child: ViewError(error: 'No Data'));
      },
    );
  }

  Widget _getItem(int index, MessageModel messageModel) {
    return BoxMessageItem(
      isRead: messageModel.isRead ?? false,
      ayah: messageModel.name ?? '',
      ayahInfo: _getAyahInfo(messageModel),
      narrationName: messageModel.name,
      userImage: messageModel.owner?.image ?? '',
      userName: _user(messageModel.owner),
      dateStr: (messageModel.finishedAt != null)
          ? DateFormat('hh:mm dd MMM')
              .format(DateTime.parse(messageModel.finishedAt ?? ''))
          : null,
      action: () {
        Get.to(() => const MessageDetails());
      },
    );
  }

  String _getAyahInfo(MessageModel messageModel) {
    String? str =
        'سورة ${messageModel.chapterName} من آية ${messageModel.verseIds![0]} الي آية ${messageModel.verseIds![messageModel.verseIds!.length - 1]}';
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
}
