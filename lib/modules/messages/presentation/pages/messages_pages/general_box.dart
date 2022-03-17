import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_base/modules/data/model/GeneralResponse.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagetap_cubit.dart';
import 'package:flutter_base/modules/messages/presentation/pages/messages/message_details.dart';
import 'package:flutter_base/modules/messages/presentation/pages/messages/recitation_details.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/general_message_item.dart';

import 'package:flutter/services.dart';
import 'package:flutter_base/lib_edit/wave/just_waveform.dart';
import 'package:flutter_base/modules/messages/presentation/pages/general_actions/liked_page.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_item_sub.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class GeneralMessagePage extends StatefulWidget {
  const GeneralMessagePage({Key? key}) : super(key: key);

  @override
  State<GeneralMessagePage> createState() => _GeneralMessagePageState();
}

class _GeneralMessagePageState extends State<GeneralMessagePage> {
  int _selectedPlay = -1;
  final List<int> _liked = [];

  final BehaviorSubject<WaveformProgress> streamWave =
      BehaviorSubject<WaveformProgress>();

  late Waveform waveform;

  late MessageTapCubit? cubit;

  @override
  void initState() {
    super.initState();

    cubit = MessageTapCubit.get(context);
    Future.delayed(Duration.zero, _init);
  }

  Future<void> _init() async {
    final waveFile2 =
        File(p.join((await getTemporaryDirectory()).path, 'waveform.wave'));
    try {
      await waveFile2.writeAsBytes(
          (await rootBundle.load('assets/audio/waveform.wave'))
              .buffer
              .asUint8List());

      waveform = await JustWaveform.parse(waveFile2);

      //    JustWaveform.parse(waveFile);

      streamWave.add(WaveformProgress(1, waveform));
    } catch (e) {
      debugPrint('Eror audio' + e.toString());
    }
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

  Widget _getItem(int index, GeneralResponse generalResponse) {
    return GeneralMessageItem(
      boxMessageItem: SubMessageItem(
        isRead: false,
        ayah: generalResponse.name ?? '',
        userInfo: _getUserInfo(generalResponse.owner),
        ayahInfo: '',
        userImage: generalResponse.owner!.image ?? '',
        userName: generalResponse.owner!.firstName.toString() +
            ' ' +
            generalResponse.owner!.lastName.toString(),
        dateStr: (generalResponse.finishedAt != null)
            ? DateFormat('hh:mm dd MMM')
                .format(DateTime.parse(generalResponse.finishedAt ?? ''))
            : null,
        color: AppColor.transparent,
        action: () {
          print('prcess ');
          Get.to(const MessageDetails());
        },
        isCertic: generalResponse.owner!.isCertified ?? true,
      ),
      progressStream: streamWave,
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
      likeCount: 20 + (_liked.contains(index) ? 1 : 0),
      trggelPlay: () {
        setState(() {
          _selectedPlay = index;
        });
      },
      viewBottom: true,
      isPlay: index == _selectedPlay, recordPath: '', wavePath: '',
    );
  }

  Widget getItem2(int index) {
    return GeneralMessageItem(
      boxMessageItem: SubMessageItem(
        isCertic: true,
        isRead: false,
        ayah: 'صِرَٰطَ ٱلَّذِينَ أَنۡعَمۡتَ عَلَيۡهِمۡ غَيۡرِ ٱلۡمَغۡضُوبِ',
        ayahInfo: 'الفاتحة من آية رقم 1 الي آية رقم 7',
        userImage: AppImages.duserImage,
        userName: 'userRecitation',
        dateStr: '9:30 15 Nev',
        color: AppColor.transparent,
        action: () {
          print('prcess ');
          Get.to(const RecitationDetails());
        },
      ),

      viewBottom: true,
      progressStream: streamWave,
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
      likeCount: 20 + (_liked.contains(index) ? 1 : 0),
      trggelPlay: () {
        setState(() {
          _selectedPlay = index;
        });
      },
      isPlay: index == _selectedPlay, recordPath: '', wavePath: '',
    );
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
