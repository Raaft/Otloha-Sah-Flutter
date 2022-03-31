import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/pagination/view/pagination_view.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_base/modules/recitations/presentation/widget/recitation_item.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:quran_widget_flutter/model/verse.dart';

import '../../../../data_source/models/database_model/recitations.dart';
import '../../../../core/exception_indicators/error_indicator.dart';
import '../../business_logic/cubit/userrecitation_cubit.dart';
import '../widget/popup_recitation.dart';

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
            return _showData();
          } else if (state is UserRecitationError) {
            return Expanded(child: ErrorIndicator(error: state.error));
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

  _showData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PaginationData<Recitations>(
        getData: (nextLink) async {
          return await cubit?.getNextData(nextLink);
        },
        drowItem: (results, index) {
          return _getItem(results, index, cubit!.userRecitationVerses);
        },
        initData: cubit!.userRecitatios!,
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
      Recitations results, int index, List<List<Verse>> userRecitationVerses) {
    return RecitationItem(
      hasMenu: true,
      id: results.id!,
      onLongPress: (() async {
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
      recordPath: results.record,
      wavePath: results.wave,
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

  _getAyahInfo(Recitations results) {
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
