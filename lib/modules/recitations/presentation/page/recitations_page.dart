import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_base/modules/data/model/recitations.dart';
import 'package:flutter_base/modules/recitations/presentation/widget/popup_recitation.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/general_message_item.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_item_sub.dart';
import 'package:flutter_base/modules/recitations/business_logic/cubit/userrecitation_cubit.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:quran_widget_flutter/model/verse.dart';

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
    cubit!.fetchRecitation();
    return Expanded(
      child: BlocBuilder<UserRecitationCubit, UserRecitationState>(
        builder: (context, state) {
          if (state is UserRecitationFetched ||
              state is RemoveUserRecitationState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: cubit!.userRecitatios!.results!.length,
                itemBuilder: (context, index) {
                  return _getItem(cubit!.userRecitatios!.results![index], index,
                      cubit!.userRecitationVerses);
                },
              ),
            );
          } else if (state is UserRecitationError) {
            return const ViewError(error: 'Not Found Data');
          } else if (state is AuthErrorState) {
            Future.microtask(
              () => Navigator.of(context)
                  .pushReplacementNamed(LoginPage.routeName),
            );
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

  Widget _getItem(
      Results results, int index, List<List<Verse>> userRecitationVerses) {
    return GeneralMessageItem(
      boxMessageItem: SubMessageItem(
        hasMenu: true,
        id: results.id!,
        showPopup: (() async {
          Get.bottomSheet(
            PopupRecitation(
              isOwner: true,
              isTeacher: false,
              actions: const [
                PopupActions.delete,
                PopupActions.addToGeneral,
                PopupActions.send,
                PopupActions.markAsFinished,
              ],
              delete: () {
                cubit!.deleteRecitation(index);
              },
              id: results.id!,
              finishedAt: results.finishedAt ?? '',
              showInGeneral: results.showInGeneral ?? false,
            ),
          );
          await cubit!.fetchRecitation();
        }),
        isRead: false,
        ayah: userRecitationVerses[index].first.text ?? '',
        ayahInfo: _getAyahInfo(results),
        narrationName: results.narrationName,
        userImage: results.owner!.image ?? '',
        userName: _user(results.owner),
        dateStr: (results.finishedAt != null)
            ? DateFormat('hh:mm dd MMM')
                .format(DateTime.parse(results.finishedAt ?? ''))
            : null,
        color: AppColor.transparent,
        userInfo: (results.owner!.level ?? '') +
            ' ' +
            (results.owner!.isATeacher ?? false
                ? translate('Teacher')
                : translate('Student')),
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
