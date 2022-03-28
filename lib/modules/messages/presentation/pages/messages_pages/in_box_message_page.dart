// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_base/data_source/models/message_model/message_model.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_base/modules/messages/presentation/pages/messages/message_details.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../business_logic/cubit/messagetap_cubit.dart';
import '../../widgets/box_message_item.dart';

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
                itemCount: cubit!.messageRecieve!.length,
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
      id: messageModel.id!,
      isRead: messageModel.isRead ?? false,
      ayah: messageModel.recitation!.name ?? '',
      ayahInfo: _getAyahInfo(messageModel.recitation),
      narrationName: messageModel.recitation!.narrationId.toString(),
      userImage: messageModel.recitation!.owner?.image ?? '',
      userName: _user(messageModel.recitation!.owner!),
      userInfo: messageModel.recitation!.owner!.level! +
          ((messageModel.recitation!.owner!.isATeacher ?? false)
              ? 'Teacher'
              : 'Student'),
      dateStr: (messageModel.recitation!.finishedAt != null)
          ? DateFormat('hh:mm dd MMM')
              .format(DateTime.parse(messageModel.recitation!.finishedAt ?? ''))
          : null,
      action: () {
        Get.to(() => MessageDetailsPage(
              msgId: messageModel.id ?? 0,
              recitationId: messageModel.recitation!.id ?? 0,
            ));
      },
    );
  }

  String _getAyahInfo(Recitation? recitation) {
    String? str =
        'سورة ${recitation!.chapterId ?? 0} من آية ${recitation.verseIds![0]} الي آية ${recitation.verseIds![recitation.verseIds!.length - 1]}';
    return str;
  }

  String _user(Owner owner) {
    var str = (owner.lastName!.isEmpty && owner.firstName!.isEmpty)
        ? (owner.username)
        : '';
    return (owner.firstName ?? '') + ' ' + (owner.lastName ?? '') + (str ?? '');
  }
}
