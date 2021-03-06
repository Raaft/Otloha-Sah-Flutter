import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/core/exception_indicators/error_indicator.dart';
import 'package:flutter_base/core/pagination/view/pagination_view.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/data_source/data_source.dart';
import 'package:flutter_base/data_source/models/home_models/user_profile.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/teacherviewtype_cubit.dart';
import '../widgets/item_teacher.dart';

import '../../../../data_source/models/database_model/teacher_response_entity.dart';

class StudentsPage extends StatefulWidget {
  static const routeName = '/students';

  const StudentsPage({Key? key}) : super(key: key);

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  bool _type = true;

  late TeacherviewtypeCubit? cubit;

  @override
  void initState() {
    super.initState();

    cubit = TeacherviewtypeCubit.get(context);
    cubit!.getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TeacherviewtypeCubit, TeacherviewtypeState>(
          builder: (context, state) {
            if (state is TeacherviewtypeChange) {
              _type = state.type;
            }
            return Column(
              children: [_topView(), _viewDate(state)],
            );
          },
        ),
      ),
    );
  }

  _viewDate(TeacherviewtypeState state) {
    if (state is TeacherErrorState) {
      return Expanded(child: ErrorIndicator(error: state.error));
    } else if (state is TeacherFetchedState || state is TeacherviewtypeChange) {
      if (cubit!.teachers != null && cubit!.teachers!.isNotEmpty) {
        return _viewItems();
      } else {
        return const Expanded(
            child: ErrorIndicator(
          error: EmptyListException,
        ));
      }
    } else if (state is TeacherErrorState) {
      return Expanded(
          child: ErrorIndicator(
        error: state.error,
      ));
    }

    if (state is NoAuthState) {
      Future.microtask(() =>
          Navigator.of(context).pushReplacementNamed(LoginPage.routeName));
    }
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Expanded _viewItems() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _type
            ? _showData()
            : GridView.builder(
                itemCount: cubit!.teachers!.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 2.45,
                ),
                itemBuilder: (context, index) {
                  return _itemView(index, cubit!.teachers![index]);
                },
              ),
      ),
    );
  }

  _showData() {
    return PaginationData<TeacherResponse>(
      getData: (nextLink) async {
        return await cubit?.getNextStudents(nextLink);
      },
      drowItem: (results, index) {
        return _itemView(index, results);
      },
      initData: cubit!.teachers!,
    );
  }

  _itemView(int index, TeacherResponse results) {
    return BlocBuilder<TeacherviewtypeCubit, TeacherviewtypeState>(
      builder: (context, state) {
        var teacherViewCubit = TeacherviewtypeCubit.get(context);
        UserProfile? userProfile;
        Future<UserProfile?> profile() async {
          userProfile = await AppDataSource().myProfile();
          return userProfile;
        }

        return ItemTeacher(
          userName: results.firstName! + ' ' + results.lastName!,
          rate: "${results.rate ?? ''}",
          userId: (results.level ?? '') + tr('Student'),
          userbio: results.bio ?? '',
          action: () {},
          typeView: _type,
          isCertified: results.isCertified ?? false,
          isFav: false,
          isStudent: true,
          setFav: () {
            teacherViewCubit.markAsFavTeacher(id: results.id, results: results);
          },
        );
      },
    );
  }

  Widget _topView() {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      // onSearch: (val) {},
      // actionIcon: IconButton(
      //   icon: Icon(_type ? Icons.grid_view : Icons.list),
      //   onPressed: () {
      //     BlocProvider.of<TeacherviewtypeCubit>(context).changeType(!_type);
      //   },
      // ),
      title: translate('Students'),
    );
  }
}
