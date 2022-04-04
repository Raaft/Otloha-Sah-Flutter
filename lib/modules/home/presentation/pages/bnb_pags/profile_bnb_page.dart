import 'package:flutter/material.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/profile_pic_cubit/profile_page_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../../auth_module/presentation/pages/login_page.dart';
import '../../widget/profile_pagw_widget.dart';
import '../coming_soon/coming_soon_page.dart';

class ProfileBNBPage extends StatelessWidget {
  ProfileBNBPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfilePageCubit, ProfilePageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ProfilePageCubit.get(context);
        if (state is NoAuthState) {
          Future.delayed(const Duration(seconds: 1), () {
            print('object');
            Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
          });
        }
        if (state is GetProfilePageLoading) {
          return const Center( child: CircularProgressIndicator(),);
        }
        if (cubit.currentUserProfile==null) {
          return const Center( child: CircularProgressIndicator(),);
        }

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: profilePageBody(cubit),

          //ComingSoonPage(),
        );
      },
    );
  }


}
