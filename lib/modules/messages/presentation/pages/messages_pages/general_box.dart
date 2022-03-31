import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/genaralmessage_cubit.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_widget.dart';
import '../../../../../core/exception_indicators/error_indicator.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../../../data_source/models/message_model/general_response.dart';
import '../../../../auth_module/presentation/pages/login_page.dart';
import '../../widgets/general_message_item.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/exceptions.dart';

class GeneralMessagePage extends StatefulWidget {
  const GeneralMessagePage({Key? key}) : super(key: key);

  @override
  State<GeneralMessagePage> createState() => _GeneralMessagePageState();
}

class _GeneralMessagePageState extends State<GeneralMessagePage> {
  // int _selectedPlay = -1;
  // final List<int> _liked = [];

  late GenaralmessageCubit? cubit;

  @override
  void initState() {
    super.initState();

    cubit = GenaralmessageCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenaralmessageCubit, GenaralmessageState>(
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
          /// return const Expanded(child: ViewError(error: 'No Data'));
          print('asdaksjnd');
          return Expanded(child: ErrorIndicator(error: state.error));
        }
        if (state is GenaralSuccessState) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: cubit?.generalResponses?.length,
                itemBuilder: (context, index) {
                  return _getItem(index, cubit!.generalResponses![index]);
                  //return textView(cubit!.generalResponses![index]);
                },
              ),
            ),
          );
        }
        return Expanded(child: ErrorIndicator(error: SomeThingWentWrong()));
      },
    );
  }

  textView(GeneralResponse generalResponse) {
    return MessageWidget(
      userImage: generalResponse.owner!.image,
      ayahInfoView: const Text('data'),
      ayahView: const Text('data'),
      dataView: const Text('data'),
      footerView: const Text('data'),
      userName: const Text('data'),
      waveView: const Text('data'),
      color: AppColor.selectColor1,
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
      isRead: false,
      ownerId: generalResponse.owner?.id ?? 0,
      id: generalResponse.id,
      ayah: generalResponse.name ?? '',
      userInfo: _getUserInfo(generalResponse.owner),
      ayahInfo: _getAyahInfo(generalResponse),
      narrationName: generalResponse.narrationName,
      userImage: generalResponse.owner?.image ?? '',
      userName: _user(generalResponse.owner),
      dateStr: (generalResponse.finishedAt != null)
          ? DateFormat('hh:mm dd MMM')
              .format(DateTime.parse(generalResponse.finishedAt ?? ''))
          : null,
      color: AppColor.transparent,
      onPress: () {
        // print('prcess ');
        //   Get.to(const MessageDetails());
      },
      isCertic: generalResponse.owner?.isCertified ?? true,
      isLocal: false,
    );
  }

  String _getAyahInfo(GeneralResponse generalResponse) {
    String? str =
        'سورة ${generalResponse.chapterName ?? 0} من آية ${generalResponse.verseIds?[0]} الي آية ${generalResponse.verseIds?[generalResponse.verseIds!.length - 1]}';
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


/*
   waveform: waveform,
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
      remarkableCount: generalResponse.remarkable?.length ?? 0, */