import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/teachers/business_logic/cubit/teacherviewtype_cubit.dart';
import 'package:flutter_base/modules/teachers/presentation/widgets/item_teacher.dart';

class StudentsPage extends StatefulWidget {
  static const routeName = '/students';

  const StudentsPage({Key? key}) : super(key: key);

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  bool _type = true;
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
              children: [_topView(), _viewItems()],
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
                itemCount: 15,
                itemBuilder: (context, index) {
                  return _itemView(index);
                },
              )
            : GridView.builder(
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 2.2,
                ),
                itemBuilder: (context, index) {
                  return _itemView(index);
                },
              ),
      ),
    );
  }

  ItemTeacher _itemView(int index) {
    return ItemTeacher(
      userName: 'user Name',
      rate: '3.4',
      userId: 'User202Team',
      userbio:
          'Proident duis sint pariatur aliquip nostrud Lorem velit tempor duis amet mollit.',
      action: () {},
      typeView: _type,
      isCertified: index % 2 == 0,
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
      actionIcon: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(_type ? Icons.grid_view : Icons.list),
            onPressed: () {
              BlocProvider.of<TeacherviewtypeCubit>(context).changeType(!_type);
            },
          ),
        ],
      ),
      title: translate('Students'),
    );
  }
}