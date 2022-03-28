import 'package:flutter/material.dart';
import 'package:flutter_base/core/widgets/auth_navigator.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_base/modules/home/presentation/widget/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

import '../../widget/float_menu_widget.dart';
import '../../widget/init_data.dart';

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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            if (cubit.isFloatingMenu || state is IsFloatingTrueMenuState) {
              cubit.changeIsOnTruePressed();
              cubit.changeOpacity(1);
              Future.delayed(const Duration(seconds: 5), () {
                cubit.changeIsOnFalsePressed();
                cubit.changeOpacity(.2);
              });
              return false;
            } else if (_index > 0) {
              cubit.changeIndex(0);
              return false;
            } else {
              return true;
            }
          },
          child: AuthNavigator(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                var cubit = HomeCubit.get(context);
                return Stack(
                  children: [
                    Scaffold(
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

                          ///
                          return BubbleBottomBarApp(
                            onItemTapped: (int? index) {
                              _changePage(index).then((value) {
                                Future.delayed(
                                  const Duration(milliseconds: 50),
                                  () {
                                    if (index == 1) {
                                      BlocProvider.of<HomeCubit>(context)
                                          .changePluginPage(
                                              page: PageType.quran);
                                    }
                                  },
                                );
                              });
                            },
                            selectedIndex: _index,
                            items: homeMenuItems,
                          );
                        },
                      ),
                    ),
                    if (cubit.isFloatingMenu ||
                        state is IsFloatingTrueMenuState)
                      const FloatingMenu()
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future _changePage(index) async {
    BlocProvider.of<HomeCubit>(context).changeIndex(index ?? 0);
  }
}
