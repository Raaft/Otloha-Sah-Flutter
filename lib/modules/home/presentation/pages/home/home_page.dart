import 'package:flutter/material.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_base/modules/home/data/models/utils/init_data.dart';
import 'package:flutter_base/modules/home/presentation/widget/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        BlocProvider.of<HomeCubit>(context).changeIndex(
            (ModalRoute.of(context)!.settings.arguments as int?) ?? 0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_index > 0) {
          BlocProvider.of<HomeCubit>(context).changeIndex(0);
          return false;
        } else {
          return true;
        }
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
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
                return (!cubit.isFloatingMenu)
                    ? BubbleBottomBarApp(
                        onItemTapped: _changePage,
                        selectedIndex: _index,
                        items: homeMenuItems,
                      )
                    : Container(
                        height: 0,
                      );
              },
            ),
          );
        },
      ),
    );
  }

  _changePage(int? index) {
    BlocProvider.of<HomeCubit>(context).changeIndex(index ?? 0);
  }
}
