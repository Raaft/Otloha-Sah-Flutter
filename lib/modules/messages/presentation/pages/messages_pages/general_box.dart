import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/data_source/models/message_model/general_response.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagetap_cubit.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/general_message_item.dart';

import 'package:flutter_base/modules/messages/presentation/pages/general_actions/liked_page.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_item_sub.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralMessagePage extends StatefulWidget {
  const GeneralMessagePage({Key? key}) : super(key: key);

  @override
  State<GeneralMessagePage> createState() => _GeneralMessagePageState();
}

class _GeneralMessagePageState extends State<GeneralMessagePage> {
  int _selectedPlay = -1;
  final List<int> _liked = [];

  late MessageTapCubit? cubit;

  @override
  void initState() {
    super.initState();

    cubit = MessageTapCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageTapCubit, MessageTapState>(
      builder: (context, state) {
        if (state is GenaralLoadingState) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is NoAuthState) {
          Future.delayed(const Duration(seconds: 1), () {
            print('object');
            Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
          });
        }
        if (state is GenaralErrorState) {
          return const Expanded(child: ViewError(error: 'No Data'));
        }
        if (state is GenaralSuccessState) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: cubit!.generalResponses!.length,
                itemBuilder: (context, index) {
                  return _getItem(index, cubit!.generalResponses![index]);
                },
              ),
            ),
          );
        }
        return const Expanded(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
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

  Widget _getItem(int index, GeneralResponse generalResponse) {
    return GeneralMessageItem(
      boxMessageItem: SubMessageItem(
        isRead: false,
        id: generalResponse.id!,
        ayah: generalResponse.name ?? '',
        userInfo: _getUserInfo(generalResponse.owner),
        ayahInfo: _getAyahInfo(generalResponse),
        narrationName: generalResponse.narrationName,
        userImage: generalResponse.owner!.image ?? '',
        // owner: generalResponse.owner ?? null,
        userName: _user(generalResponse.owner),
        dateStr: (generalResponse.finishedAt != null)
            ? DateFormat('hh:mm dd MMM')
                .format(DateTime.parse(generalResponse.finishedAt ?? ''))
            : null,
        color: AppColor.transparent,
        action: () {
          // print('prcess ');
          //   Get.to(const MessageDetails());
        },
        isCertic: generalResponse.owner!.isCertified ?? true,
      ),
      isLocal: false,
      //  waveform: waveform,
      isLike: _liked.contains(index),
      liked: () {
        setState(() {
          _liked.add(index);
        });
      },
      goLike: () =>
          Navigator.of(context).pushNamed(LikedPage.routeName, arguments: 0),
      goNote: () =>
          Navigator.of(context).pushNamed(LikedPage.routeName, arguments: 1),
      goReMraker: () =>
          Navigator.of(context).pushNamed(LikedPage.routeName, arguments: 2),
      likeCount: (generalResponse.likes?.length ?? 0) +
          (_liked.contains(index) ? 1 : 0),
      trggelPlay: () {
        setState(() {
          _selectedPlay = index;
        });
      },
      viewBottom: true,
      isPlay: index == _selectedPlay, recordPath: '', wavePath: '',
      commentCount: generalResponse.comments?.length ?? 0,
      remarkableCount: generalResponse.remarkable?.length ?? 0,
    );
  }

  String _getAyahInfo(GeneralResponse generalResponse) {
    String? str =
        'سورة ${generalResponse.chapterName ?? 0} من آية ${generalResponse.verseIds![0]} الي آية ${generalResponse.verseIds![generalResponse.verseIds!.length - 1]}';
    return str;
  }

  _getUserInfo(Owner? owner) {
    if (owner != null) {
      if (owner.isATeacher ?? false) {
        return '${owner.level} Student';
      } else {
        return '${owner.teacherType ?? ''} Teacher';
      }
    }
    return ' ';
  }
}
