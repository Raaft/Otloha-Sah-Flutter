import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/data/model/recitations.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/teachersend_cubit.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/userrecitation_cubit.dart';
import 'package:flutter_base/modules/home/presentation/widget/popup_chose_teacher_send.dart';
import 'package:flutter_base/modules/home/presentation/widget/popup_recitation.dart';
import 'package:flutter_base/modules/messages/presentation/pages/messages/recitation_details.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/general_message_item.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_item_sub.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
    return GeneralMessageItem(
      boxMessageItem: SubMessageItem(
        hasMenu: true,
        showPopup: (() {
          Get.bottomSheet(
            PopupRecitation(
              finish:
                  (results.finishedAt == null || results.finishedAt!.isEmpty)
                      ? () {
                          cubit!.markAsFinished(results.id ?? 0);
                          Get.back();
                        }
                      : null,
              general: ((results.finishedAt != null &&
                      results.finishedAt!.isNotEmpty))
                  ? () {
                      cubit!.addToGeneral(results.id ?? 0);

                      Get.back();
                    }
                  : null,
              isGeneral: results.showInGeneral ?? false,
              send:
                  (results.finishedAt != null && results.finishedAt!.isNotEmpty)
                      ? () {
                          Get.back();
                          Get.bottomSheet(
                            BlocProvider(
                              create: (_) => TeachersendCubit(),
                              child: const PopupChooseTeacherSend(),
                            ),
                          );
                        }
                      : null,
              delete: () {
                cubit!.deleteRecitations(results.id ?? 0);
                Get.back();
              },
            ),
          );
        }),
        isRead: false,
        ayah: results.name ?? '',
        ayahInfo: _getAyahInfo(results),
        narrationName: results.narrationName,
        userImage: results.owner!.image ?? '',
        userName: results.owner!.firstName! + results.owner!.lastName!,
        dateStr: (results.finishedAt != null)
            ? DateFormat('hh:mm dd MMM')
                .format(DateTime.parse(results.finishedAt ?? ''))
            : null,
        color: AppColor.transparent,
        userInfo: (results.owner!.level ?? '') +
            (results.owner!.isATeacher ?? false ? ' Teacher' : ' Student'),
        action: () {
          Get.to(const RecitationDetails());
        },
      ),
      likeCount: results.likes!.length,
      commentCount: results.comments!.length,
      remarkableCount: results.remarkable!.length,
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
    );
  }

  _getAyahInfo(Results results) {
    /*   Scaffold.of(context).showBottomSheet((context) {
      return BlocProvider(
        create: (context) => TeachersendCubit(),
        child: const PopupChooseTeacherSend(),
      );
    });*/

    return (results.chapterName ?? '') +
        ' من آية ${results.versesID![0]} الي أية ${results.versesID![results.versesID!.length - 1]}';
  }
}
