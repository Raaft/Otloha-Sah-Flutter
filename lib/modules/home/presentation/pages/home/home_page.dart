import 'package:flutter/material.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/profile_pic_cubit/profile_page_cubit.dart';
import '../../../../../core/widgets/auth_navigator.dart';
import '../../../business_logic/cubit/home_cubit.dart';
import '../../widget/bottom_bar.dart';
import '../../widget/init_data.dart';
import '../../../../quran/business_logic/cubit/quran_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

import '../../../../quran/presentation/widget/float_menu_widget.dart';

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
        var cubitView = QuranViewCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            if (cubit.isFloatingMenu || state is IsFloatingTrueMenuState) {
              cubit.changeIsOnTruePressed();
              cubitView.changeIsOnTruePressed();
              // cubit.changeOpacity(1);
              cubitView.changeOpacity(1);
              Future.delayed(const Duration(seconds: 5), () {
                cubit.changeIsOnFalsePressed();
                cubitView.changeIsOnFalsePressed();
                // cubit.changeOpacity(.2);
                cubitView.changeOpacity(.2);
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
                                    if (index == 3) {
                                      BlocProvider.of<ProfilePageCubit>(context)
                                          .userProfile();
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
