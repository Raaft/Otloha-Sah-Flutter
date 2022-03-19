import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/data/model/recitations.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/userrecitation_cubit.dart';
import 'package:flutter_base/modules/home/presentation/widget/popup_recitation.dart';
import 'package:flutter_base/modules/home/presentation/widget/recitation_item.dart';
import 'package:flutter_base/modules/messages/data/data_source/messages_servise.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/general_message_item.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_item_sub.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
    cubit!.fetchRecitation();
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
                itemCount: cubit!.userRecitatios!.results!.length,
                itemBuilder: (context, index) {
                  return _getItem(
                      cubit!.userRecitatios!.results![index], index);
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

  Widget _getItem(Results results, int index) {
    return RecitationItem(
      showPopup: (() {
        Get.bottomSheet(
          PopupRecitation(
            finish: () {
              cubit!.markAsFinished(results.id ?? 0);
            },
            general: () {
              cubit!.addToGeneral(results.id ?? 0);
            },
            delete: () {
              cubit!.deleteRecitations(results.id ?? 0);
            },
          ),
        );
      }),
      generalMessageItem: GeneralMessageItem(
        boxMessageItem: SubMessageItem(
          isRead: false,
          ayah: results.name ?? '',
          ayahInfo: _getAyahInfo(results),
          narrationName: results.narrationName,
          userImage: results.owner!.image ?? '',
          userName: results.name!,
          dateStr: (results.finishedAt != null)
              ? DateFormat('hh:mm dd MMM')
                  .format(DateTime.parse(results.finishedAt ?? ''))
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
        viewBottom: true,
        recordPath: results.record,
        wavePath: results.wave,
        isLocal: false,
      ),
    );
  }

  _getAyahInfo(Results results) {
    return (results.chapterName ?? '') +
        ' من آية ${results.versesID![0]} الي أية ${results.versesID![results.versesID!.length - 1]}';
  }
}
