import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_base/modules/data/model/teacher_response_entity.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_base/modules/teachers/business_logic/cubit/teacherviewtype_cubit.dart';
import 'package:flutter_base/modules/teachers/presentation/widgets/item_teacher.dart';

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

            return Column(
              children: [_topView(), _viewDate(state)],
            );
          },
        ),
      ),
    );
  }

  Expanded _viewItems() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _type
            ? ListView.builder(
                itemCount: cubit!.teachers!.results!.length,
                itemBuilder: (context, index) {
                  return _itemView(index, cubit!.teachers!.results![index]);
                },
              )
            : GridView.builder(
                itemCount: cubit!.teachers!.results!.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 2.45,
                ),
                itemBuilder: (context, index) {
                  return _itemView(index, cubit!.teachers!.results![index]);
                },
              ),
      ),
    );
  }

  ///test

  ItemTeacher _itemView(int index, Results results) {
    return ItemTeacher(
      userName: results.firstName! + ' ' + results.lastName!,
      rate: "${results.rate ?? ''}",
      userId: (results.teacherType ?? '') + ' Teacher',
      userbio: results.bio ?? '',
      action: () {},
      typeView: _type,
      isCertified: results.isCertified ?? false,
      isFav: index == _selected,
      setFav: () {
        setState(() {
          _selected = index;
        });
      },
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
      actionIcon: IconButton(
        icon: Icon(_type ? Icons.grid_view : Icons.list),
        onPressed: () {
          BlocProvider.of<TeacherviewtypeCubit>(context).changeType(!_type);
        },
      ),
      title: translate('Teachers'),
    );
  }

  _viewDate(TeacherviewtypeState state) {
    if (state is TeacherErrorState) {
      return const Expanded(child: ViewError(error: 'No Data'));
    } else if (state is TeacherFetchedState) {
      return _viewItems();
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
