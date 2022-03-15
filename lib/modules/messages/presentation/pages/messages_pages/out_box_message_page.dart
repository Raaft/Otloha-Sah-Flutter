import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagetap_cubit.dart';
import 'package:flutter_base/modules/messages/data/models/MessageModel.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/box_message_item.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutBoxMessagePage extends StatelessWidget {
  OutBoxMessagePage({Key? key}) : super(key: key);

  late MessageTapCubit? cubit;

  @override
  Widget build(BuildContext context) {
    cubit = MessageTapCubit.get(context);
    return BlocBuilder<MessageTapCubit, MessageTapState>(
      builder: (context, state) {
        if (state is MessageSendSuccessLoadingState) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is MessageSendErrorState) {
          return const Expanded(child: ViewError(error: 'No Data'));
        }
        if (state is MessageSendSuccessState) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: cubit!.messageSendList!.length,
                itemBuilder: (context, index) {
                  return _getItem(index, cubit!.messageSendList![index]);
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
      isActive: ((index % 3) == 0),
      ayah: 'أن الذين كفروا سواء عليهم',
      ayahInfo: 'Juz-1  6-Ayah البقرة',
      userImage: AppImages.duserImage,
      userName: 'Mohamed Ahmed',
      dateStr: '9:30 15 Nov',
    );
  }
}
