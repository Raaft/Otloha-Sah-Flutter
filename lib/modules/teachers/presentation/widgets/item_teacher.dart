import 'package:flutter/material.dart';
import 'package:flutter_base/data_source/models/database_model/teacher_response_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/res/icons_app.dart';
import '../../../../core/utils/res/images_app.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';
import '../../business_logic/cubit/teacherviewtype_cubit.dart';

class ItemTeacher extends StatelessWidget {
  const ItemTeacher({
    Key? key,
    required this.userName,
    required this.rate,
    required this.userId,
    required this.userbio,
    required this.action,
    required this.typeView,
    this.isCertified = false,
    this.setFav,
    this.isFav,
    this.isStudent = false,
    this.results,
  }) : super(key: key);
  final TeacherResponse? results;
  final bool typeView;
  final bool isCertified;
  final bool? isFav;
  final bool isStudent;

  final String userName;
  final String rate;
  final String userId;
  final String userbio;

  final Function()? action;
  final Function()? setFav;

  @override
  Widget build(BuildContext context) {
    final Widget view;

    if (typeView) {
      view = Row(
        /// crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _userImage(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextView(
                            text: userName,
                            weightText: FontWeight.bold,
                            padding: EdgeInsets.zero,
                            sizeText: 18,
                            colorText: AppColor.txtColor4,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          if (!isStudent && isCertified)
                            Image.asset(
                              AppIcons.qualityIcon,
                              color: AppColor.iconColor5,
                              width: 16,
                              height: 16,
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: rate,
                            weightText: FontWeight.bold,
                            padding: EdgeInsets.zero,
                            sizeText: 18,
                            colorText: AppColor.txtColor4,
                          ),
                          Row(
                            children: [
                              ..._iconsView(20),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextView(
                        text: userId,
                        padding: EdgeInsets.zero,
                        sizeText: 16,
                        colorText: AppColor.txtColor4,
                        // textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  TextView(
                    text: userbio,
                    padding: EdgeInsets.zero,
                    sizeText: 14,
                    colorText: AppColor.txtColor4,
                    textAlign: TextAlign.start,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          )
        ],
      );
    } else {
      view = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _userImage(),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: userName,
                weightText: FontWeight.bold,
                padding: EdgeInsets.zero,
                sizeText: 18,
                colorText: AppColor.txtColor4,
              ),
              const SizedBox(
                width: 8,
              ),
              if (isCertified && !isStudent)
                Image.asset(
                  AppIcons.qualityIcon,
                  color: AppColor.iconColor5,
                  width: 16,
                  height: 16,
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: userId,
                padding: EdgeInsets.zero,
                sizeText: 14,
                colorText: AppColor.txtColor4,
                textAlign: TextAlign.start,
              ),
              TextView(
                text: rate,
                weightText: FontWeight.bold,
                padding: EdgeInsets.zero,
                sizeText: 14,
                colorText: AppColor.txtColor4,
                textAlign: TextAlign.start,
              ),
              ..._iconsView(16),
            ],
          ),
          // const SizedBox(height: 4),
          Text(
            userbio,
            style: TextStyle(
              fontSize: 12,
              color: AppColor.txtColor4,
            ),
            maxLines: 3,
            textAlign: TextAlign.start,
            //overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }

    return Card(
      elevation: 0,
      color: AppColor.backItem,
      child: GestureDetector(
        onTap: action,
        child: Container(
          padding: const EdgeInsets.all(4),
          child: view,
        ),
      ),
    );
  }

  SizedBox _userImage() {
    return SizedBox(
      width: 70,
      height: 70,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(AppImages.duserImage),
      ),
    );
  }

  List<Widget> _iconsView(double size) {
    return [
      Icon(
        Icons.star_border,
        color: AppColor.iconColor3,
        size: size,
      ),
      BlocBuilder<TeacherviewtypeCubit, TeacherviewtypeState>(
        builder: (context, state) {
          // var cubit = TeacherviewtypeCubit.get(context);
          return IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
            //  cubit.markAsFavTeacher(id:cubit.teachers!);
              setFav!();
            },
              icon: Icon(
              (isFav ?? false) ? (Icons.favorite) : (Icons.favorite_border),
              color:
                  (isFav ?? false) ? Colors.red : AppColor.iconColor,
              size: size,
            ),
          );
        },
      ),
    ];
  }
}
