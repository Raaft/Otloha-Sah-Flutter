import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/data/model/user_recitation.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/userrecitation_cubit.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/general_message_item.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_item_sub.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecitationsPage extends StatefulWidget {
  const RecitationsPage({Key? key}) : super(key: key);

  static const routeName = '/recitations';

  @override
  State<RecitationsPage> createState() => _RecitationsPageState();
}

class _RecitationsPageState extends State<RecitationsPage> {
  int _selectedPlay = -1;

  UserRecitationCubit? cubit;

  @override
  void initState() {
    super.initState();

    cubit = UserRecitationCubit.get(context);
    cubit!.fetchLoacl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          _topView(),
          _viewItems(),
        ],
      )),
    );
  }

  Expanded _viewItems() {
    return Expanded(
      child: BlocBuilder<UserRecitationCubit, UserRecitationState>(
        builder: (context, state) {
          if (state is UserRecitationFetched) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: cubit!.userRecitatios!.length,
                itemBuilder: (context, index) {
                  return _getItem(cubit!.userRecitatios![index], index);
                },
              ),
            );
          } else if (state is UserRecitationError) {
            return const ViewError(error: 'Not Found Data');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _topView() {
    return SearchBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: translate('Recitations'),
    );
  }

  Widget _getItem(UserRecitation userRecitation, int index) {
    return GeneralMessageItem(
      boxMessageItem: SubMessageItem(
        isRead: userRecitation.uploaded ?? false,
        ayah: userRecitation.name ?? '',
        ayahInfo: '',
        userImage: '',
        userName: 'Mohamed Ahmed',
        dateStr: (userRecitation.finishedAt != null)
            ? userRecitation.finishedAt.toString()
            : null,
        color: AppColor.transparent,
      ),
      likeCount: 20,
      isLike: (index % 2 == 0),
      trggelPlay: () {
        setState(() {
          _selectedPlay = index;
        });
      },
      isPlay: index == _selectedPlay,
      viewBottom: userRecitation.uploaded ?? false,
      recordPath: userRecitation.record,
      wavePath: userRecitation.wavePath,
      isLocal: !(userRecitation.uploaded ?? false),
    );
  }
}
