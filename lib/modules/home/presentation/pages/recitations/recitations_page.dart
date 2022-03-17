import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/lib_edit/wave/just_waveform.dart';
import 'package:flutter_base/modules/data/model/user_recitation.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/userrecitation_cubit.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/general_message_item.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_item_sub.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io';

class RecitationsPage extends StatefulWidget {
  const RecitationsPage({Key? key}) : super(key: key);

  static const routeName = '/recitations';

  @override
  State<RecitationsPage> createState() => _RecitationsPageState();
}

class _RecitationsPageState extends State<RecitationsPage> {
  int _selectedPlay = -1;
  final BehaviorSubject<WaveformProgress> streamWave =
      BehaviorSubject<WaveformProgress>();

  late Waveform waveform;

  UserRecitationCubit? cubit;

  @override
  void initState() {
    super.initState();

    cubit = UserRecitationCubit.get(context);
    cubit!.fetchLoacl();

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
        userImage: AppImages.duserImage,
        userName: 'Mohamed Ahmed',
        dateStr: (userRecitation.finishedAt != null)
            ? userRecitation.finishedAt.toString()
            : null,
        color: AppColor.transparent,
      ),
      progressStream: streamWave,
      likeCount: 20,
      isLike: (index % 2 == 0),
      trggelPlay: () {
        setState(() {
          _selectedPlay = index;
        });
      },
      isPlay: index == _selectedPlay,
      viewBottom: userRecitation.uploaded ?? false,
      recordPath: '',
      wavePath: '',
    );
  }
}
