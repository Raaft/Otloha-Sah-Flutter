import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagetap_cubit.dart';
import 'package:flutter_base/modules/messages/data/models/MessageModel.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/box_message_item.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InBoxMessagePage extends StatelessWidget {
  InBoxMessagePage({Key? key}) : super(key: key);

  late MessageTapCubit? cubit;

  @override
  Widget build(BuildContext context) {
    cubit = MessageTapCubit.get(context);
    return BlocBuilder<MessageTapCubit, MessageTapState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state is MessageRecieveSuccessLoadingState)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (state is MessageRecieveErrorState)
              const ViewError(error: 'No Data'),
            if (state is MessageRecieveSuccessState)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: cubit!.messageSendList!.length,
                    itemBuilder: (context, index) {
                      return _getItem(index, cubit!.messageSendList![index]);
                    },
                  ),
                ),
              ),
          ],
        );
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
