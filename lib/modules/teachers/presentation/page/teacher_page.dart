import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/pagination/view/pagination_view.dart';
import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/data_source/cache_helper.dart';
import 'package:flutter_base/data_source/data_source.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_base/modules/teachers/presentation/page/teacher_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_base/modules/teachers/business_logic/cubit/teacherviewtype_cubit.dart';
import 'package:flutter_base/modules/teachers/presentation/widgets/item_teacher.dart';
import 'package:get/get.dart';

import '../../../../core/exception_indicators/error_indicator.dart';
import '../../../../data_source/models/database_model/teacher_response_entity.dart';
import '../../../../data_source/models/home_models/user_profile.dart';

class TeacherPage extends StatefulWidget {
  static const routeName = '/teacher';

  const TeacherPage({Key? key}) : super(key: key);

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  bool _type = true;
  int _selected = -1;

  late TeacherviewtypeCubit? cubit;

  @override
  void initState() {
    super.initState();

    cubit = TeacherviewtypeCubit.get(context);
    cubit!.getTeacher();
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
            var cubit = TeacherviewtypeCubit.get(context);
            return Column(
              children: [_topView(), _viewDate(state, cubit)],
            );
          },
        ),
      ),
    );
  }

  _showData() {
    return PaginationData<TeacherResponse>(
      getData: (nextLink) async {
        return await cubit?.getNextTeachers(nextLink);
      },
      drowItem: (results, index) {
        return _itemView(index, results);
      },
      initData: cubit!.teachers,
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

  ///test

  _itemView(int index, TeacherResponse results) {
    if (results.isFavorite ?? false) {
      favTeacherId = results.id;
      CacheHelper.saveData(key: favTeacherIdName, value: favTeacherId);
    }
    print('narration id ${results.narrationId}');
    return BlocBuilder<TeacherviewtypeCubit, TeacherviewtypeState>(
      builder: (context, state) {
        var teacherViewCubit = TeacherviewtypeCubit.get(context);
        UserProfile? userProfile;
        Future<UserProfile?> profile() async {
          userProfile = await AppDataSource().myProfile();
          return userProfile;
        }

        return ItemTeacher(
          userName:
              (results.firstName ?? tr('Add')) + ' ' + (results.lastName ?? tr('Add')),
          rate: "${results.rate ?? ''}",
          userId: (results.teacherType ?? '') + tr('Teacher'),
          userbio: results.bio ?? '',
          action: () {
            Get.to(()=>TeacherDetails(results: results,));
          },
          typeView: _type,
          isCertified: results.isCertified ?? false,
          isFav: results.isFavorite,
          //  results: results,
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
      // actionIcon: IconButton(
      //   icon: Icon(_type ? Icons.grid_view : Icons.list),
      //   onPressed: () {
      //     BlocProvider.of<TeacherviewtypeCubit>(context).changeType(!_type);
      //   },
      // ),
      title: translate('Teachers'),
    );
  }

  _viewDate(TeacherviewtypeState state, TeacherviewtypeCubit cubit) {
    if (state is TeacherLoadingState) {
      //return _viewItems();
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state is TeacherErrorState) {
      return Expanded(child: ErrorIndicator(error: state.error));
    } else if (state is TeacherFetchedState ||
        state is MarkAsFavTeacherLoadingState ||
        state is MarkAsFavTeacherFetchedState ||
        state is TeacherviewtypeChange) {
      if (cubit.teachers != null && cubit.teachers!.isNotEmpty) {
        return _viewItems();
      } else {
        return const Expanded(child: ErrorIndicator(error: EmptyListException));
      }
    } else if (state is TeacherErrorState) {
      return Expanded(
          child: ErrorIndicator(
        error: state.error,
      ));
    }
    if (state is NoAuthState) {
      Future.delayed(const Duration(seconds: 1), () {
        print('object');
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      });
    }
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
