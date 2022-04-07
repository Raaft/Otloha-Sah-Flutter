import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constant/utils.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/tool_bar_app.dart';
import '../../../messages/business_logic/cubit/messagedetails_cubit.dart';
import '../../../messages/presentation/widgets/general_message_item.dart';
import '../widget/popup_recitation.dart';
import '../../../settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data_source/models/database_model/recitaion_details.dart';
import '../../../../data_source/models/home_models/user_profile.dart';

class RecitationDetailsPage extends StatefulWidget {
  const RecitationDetailsPage({Key? key, required this.recitationId})
      : super(key: key);

  final int recitationId;
  @override
  State<RecitationDetailsPage> createState() => _RecitationDetailsPageState();
}

class _RecitationDetailsPageState extends State<RecitationDetailsPage> {
  MessagedetailsCubit? cubit;
  late UserProfile userProfile;
  @override
  void initState() {
    super.initState();
    cubit = MessagedetailsCubit.get(context);
    cubit!.fetchRecitation(widget.recitationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _topView(context),
            _getBody(),
          ],
        ),
      ),
    );
  }

  Widget _getBody() {
    return BlocBuilder<MessagedetailsCubit, MessagedetailsState>(
      builder: (context, state) {
        if (state is MessageFetchedState) {
          return _getItem2(cubit!.recitationDetails);
        }
        if (state is MessageLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return  ViewError(error: tr('Not Found Data'));
      },
    );
  }

  Widget _getItem2(RecitationDetails? recitationDetails) {
    print('object id ${recitationDetails!.id}');
    return GeneralMessageItem(
      id: recitationDetails.id!,
      isRead: false,
      ayah: cubit!.ayah,
      ayahInfo: _getAyahInfo(recitationDetails),
      narrationName: recitationDetails.narrationName,
      userImage: recitationDetails.owner!.image ?? '',
      userName: _user(recitationDetails.owner),
      dateStr: (recitationDetails.finishedAt != null)
          ? DateFormat('hh:mm dd MMM')
              .format(DateTime.parse(recitationDetails.finishedAt ?? ''))
          : null,
      color: AppColor.transparent,
      userInfo: (recitationDetails.owner!.level ?? '') +
          (recitationDetails.owner!.isATeacher ?? false
              ? ' Teacher'
              : ' Student'),
      onPress: () {
        Get.to(RecitationDetailsPage(
          recitationId: recitationDetails.id ?? 0,
        ));
      },
      recordPath: recitationDetails.record,
      wavePath: recitationDetails.wave,
      isLocal: false,
      trggelPlay: () {},
    );
  }
  //
  // Widget _getItem() {
  //   return CommentReplayItem(
  //     isLocal: false,
  //     isRead: false,
  //     ayah: cubit!.ayah,
  //     ayahInfo: _getAyahInfo(cubit!.recitationDetails),
  //     userImage: cubit!.recitationDetails!.owner!.image ?? '',
  //     userName: _user(cubit!.recitationDetails!.owner),
  //     dateStr: (cubit!.recitationDetails!.finishedAt != null)
  //         ? DateFormat('hh:mm dd MMM').format(
  //             DateTime.parse(cubit!.recitationDetails!.finishedAt ?? ''))
  //         : null,
  //     color: AppColor.transparent,
  //     trggelPlay: () {},
  //     userInfo: cubit!.recitationDetails!.owner!.level! +
  //         ' ' +
  //         ((cubit!.recitationDetails!.owner!.isATeacher ?? false)
  //             ? translate('Teacher')
  //             : translate('Student')),
  //     recordPath: cubit!.recitationDetails!.record,
  //     wavePath: cubit!.recitationDetails!.wave ?? '',
  //     //  errorStr: '',
  //     isPlay: false, actionReply: () {},
  //   );
  // }

  String _getAyahInfo(RecitationDetails? recitation) {
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
      title: translate('RecitationDetails'),
      actionIcon: IconButton(
          onPressed: () {
            Get.bottomSheet(
              PopupRecitation(
                id: cubit!.recitationDetails!.id!,
                actions: const [
                  PopupActions.markAsFinished,
                  PopupActions.addToGeneral,
                  PopupActions.send,
                ],
                finishedAt: cubit!.recitationDetails!.finishedAt ?? '',
                showInGeneral: cubit!.recitationDetails!.showInGeneral ?? false,
                isOwner: cubit!.recitationDetails!.owner!.id == userProfile.id,
                isTeacher: userProfile.isATeacher!,
              ),
            );
          },
          icon: const Icon(Icons.more_vert)),
    );
  }
}
