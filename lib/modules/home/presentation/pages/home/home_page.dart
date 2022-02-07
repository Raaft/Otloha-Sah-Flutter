import 'package:flutter/material.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_base/modules/home/data/models/utils/init_data.dart';
import 'package:flutter_base/modules/home/presentation/widget/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeCubit>(context).changeIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeChangeIndex) {
            _index = state.index;
          }
          return SafeArea(child: homeMenuItems[_index].page);
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeChangeIndex) {
            _index = state.index;
          }
          return BubbleBottomBarApp(
            onItemTapped: _changePage,
            selectedIndex: _index,
            items: homeMenuItems,
          );
        },
      ),
    );
  }

  _changePage(int? index) {
    BlocProvider.of<HomeCubit>(context).changeIndex(index ?? 0);
  }
}