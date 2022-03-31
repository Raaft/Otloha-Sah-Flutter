import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/core/widgets/cached_image.dart';
import 'package:flutter_base/modules/teachers/presentation/page/teacher_page.dart';
import '../../../../core/utils/constant/constants.dart';
import '../../../../core/utils/constant/utils.dart';
import '../../../../core/utils/res/images_app.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';
import '../../../auth_module/presentation/pages/login_page.dart';
import '../../business_logic/cubit/teachersend_cubit.dart';

import '../../../settings/presentation/widgets/search_bar_app.dart';
import '../../../settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../data_source/models/database_model/teacher_response_entity.dart';

class PopupChooseTeacherSend extends StatefulWidget {
  const PopupChooseTeacherSend({Key? key, required this.id, this.saveRecittion})
      : super(key: key);

  final int id;
  final Function? saveRecittion;

  @override
  State<PopupChooseTeacherSend> createState() => _PopupChooseTeacherSendState();
}

class _PopupChooseTeacherSendState extends State<PopupChooseTeacherSend> {
  List<int> list = [];

  late TeacherSendCubit? cubit;
  int recitationId = 0;

  @override
  void initState() {
    super.initState();
    cubit = TeacherSendCubit.get(context);
    cubit!.sendTeacher(widget.id);
    Future.delayed(const Duration(seconds: 1), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: AppColor.white,
      child: Center(
        child: BlocBuilder<TeacherSendCubit, TeacherSendState>(
          builder: (context, state) {
            if (state is TeacherErrorState) {
              Future.microtask(() {
                Get.back();
                return Get.to(const TeacherPage());
              });
              return const ViewError(error: 'No Data');
            }

            if (state is TeacherFetchedState) {
              return _viewBody(cubit!.teachers);
              //print('object');
            }
            if (state is NoAuthState) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
              });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _viewBody(List<TeacherResponse> teachers) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.back();
    });
    return Container(
      color: AppColor.transparent,
      child: Container(
        color: AppColor.white,
        child: TextView(text: translate('SendedToFav')),
        // child: ListView(
        //   children: [
        //     ..._favTeacher(),
        //   ],
        // ),
      ),
    );
  }

  _favTeacher() {
    if (favTeacherProFile != null) {
      return [
        _tabView(context),
        TextView(
          text: translate('Send to Favorite Teacher'),
          colorText: AppColor.txtColor3,
          sizeText: 16,
          weightText: FontWeight.w700,
          padding: const EdgeInsets.all(4),
          textAlign: TextAlign.start,
        ),
        ListTile(
          leading:
              CachedImage(url: cubit!.teachers.first.image ?? '', raduis: 25),
          title: TextView(
            text: (cubit!.teachers.first != null)
                ? _user(cubit!.teachers.first)
                : 'no Fav',
            colorText: AppColor.txtColor4,
            sizeText: 16,
            weightText: FontWeight.w700,
            padding: const EdgeInsets.all(4),
            textAlign: TextAlign.start,
          ),
          trailing: IconButton(
            onPressed: () {
              _sendMessage([
                ((cubit!.teachers.first != null)
                    ? cubit!.teachers.first.id ?? 0
                    : 0)
              ]);
            },
            icon: Transform(
              alignment: Alignment.center,
              transform: isEn ? Matrix4.rotationY(pi) : Matrix4.rotationY(0),
              child: Icon(
                Icons.send,
                color: AppColor.txtColor4,
              ),
            ),
          ),
        )
      ];
    } else {
      return [Container()];
    }
  }

  _teachers(int index, TeacherResponse results) {
    return ListTile(
      leading: Container(
        margin: const EdgeInsets.all(4),
        width: 50,
        height: 50,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: FadeInImage(
            fit: BoxFit.cover,
            width: 50,
            height: 50,
            placeholder: AssetImage(AppImages.duserImage),
            image: NetworkImage(
              (results.image!.isNotEmpty)
                  ? (baseUrl + (results.image ?? ''))
                  : 'https://media-exp1.licdn.com/dms/image/C4D03AQHuILHolmwcsw/profile-displayphoto-shrink_200_200/0/1635605885835?e=2147483647&v=beta&t=QPucLhzpuEWgVZbpTislGr8cr8wtfyeuumpE0jGH9MM',
            ),
          ),
        ),
      ),
      title: TextView(
        text: _user(results),
        colorText: AppColor.txtColor4,
        sizeText: 16,
        weightText: FontWeight.w700,
        padding: const EdgeInsets.all(4),
        textAlign: TextAlign.start,
      ),
      trailing: Checkbox(
        value: list.contains(index),
        onChanged: (val) {
          setState(
            () {
              if (val ?? false) {
                list.add(index);
              } else {
                list.remove(index);
              }
            },
          );
        },
      ),
    );
  }

  String _user(user) {
    if (user != null) {
      var str = (user!.lastName!.isEmpty && user!.firstName!.isEmpty)
          ? (user!.username)
          : '';
      return (user!.firstName ?? '') +
          ' ' +
          (user!.lastName ?? '') +
          (str ?? '');
    } else {
      return '';
    }
  }

  void _sendMessage(List<int> list) async {
    cubit?.sendMessage(list, recitationId)!.then((message) {
      Get.back();
      if (message != null) {
        print('object $message');
        Get.snackbar(message, message,
            backgroundColor: AppColor.lightBlue, colorText: AppColor.txtColor2);
      }
    });
  }

  _tabView(BuildContext context) {
    return SearchBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: translate('SendTo'),
      onSearch: (val) {
        BlocProvider.of<TeacherSendCubit>(context).filter(qurey: val);
      },
    );
  }
}


/**
 *  Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: translate('SelectToSend'),
                    colorText: AppColor.txtColor3,
                    sizeText: 16,
                    weightText: FontWeight.w700,
                    padding: const EdgeInsets.all(4),
                    textAlign: TextAlign.start,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      List<int> users = [];
                      for (var element in list) {
                        users.add(teachers![element].id ?? 0);
                      }
                      if (widget.saveRecittion != null) {
                        recitationId = await widget.saveRecittion!();
                      } else {
                        recitationId = widget.id;
                      }
                      _sendMessage(users);
                    },
                    color: Colors.blue,
                    padding: const EdgeInsets.all(12),
                    shape: const CircleBorder(),
                    child: Transform(
                      alignment: Alignment.center,
                      transform:
                          isEn ? Matrix4.rotationY(pi) : Matrix4.rotationY(0),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: teachers!.length,
              itemBuilder: (context, index) {
                return _teachers(index, teachers[index]);
              },
            )
 */