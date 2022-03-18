import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/auth_module/presentation/pages/login_page.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:flutter_base/modules/data/model/teacher_response_entity.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/teachersend_cubit.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopupChooseTeacherSend extends StatefulWidget {
  const PopupChooseTeacherSend({Key? key}) : super(key: key);

  @override
  State<PopupChooseTeacherSend> createState() => _PopupChooseTeacherSendState();
}

class _PopupChooseTeacherSendState extends State<PopupChooseTeacherSend> {
  List<int> list = [];

  late TeachersendCubit? cubit;

  @override
  void initState() {
    super.initState();

    cubit = TeachersendCubit.get(context);
    cubit!.getTeacher();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeachersendCubit, TeachersendState>(
      builder: (context, state) {
        if (state is TeacherErrorState) {
          return const Expanded(child: ViewError(error: 'No Data'));
        } else if (state is TeacherFetchedState) {
          return _viewBody(cubit!.teachers);
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
      },
    );
  }

  Container _viewBody(TeacherResponse? teachers) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      color: AppColor.transparent,
      child: Container(
        color: AppColor.white,
        child: ListView(
          children: [
            const SizedBox(
              width: 250,
              height: 10,
              child: Divider(
                thickness: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                shrinkWrap: true,
                children: [
                  TextView(
                    text: translate('Send to Favorite Teacher'),
                    colorText: AppColor.txtColor3,
                    sizeText: 16,
                    weightText: FontWeight.w700,
                    padding: const EdgeInsets.all(4),
                    textAlign: TextAlign.start,
                  ),
                  _favTeacher(),
                  const SizedBox(
                    width: 250,
                    height: 10,
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(
                        text: translate('Select to Send to a Teachers'),
                        colorText: AppColor.txtColor3,
                        sizeText: 16,
                        weightText: FontWeight.w700,
                        padding: const EdgeInsets.all(4),
                        textAlign: TextAlign.start,
                      ),
                      AuthButton(
                        buttonText: 'send',
                        width: 100,
                        onPressed: () {},
                        colors: [
                          AppColor.darkBlue,
                          AppColor.lightBlue,
                        ],
                      )
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: teachers!.results!.length,
                    itemBuilder: (context, index) {
                      return _teachers(index);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _favTeacher() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.all(4),
          width: 60,
          height: 60,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: FadeInImage(
              fit: BoxFit.cover,
              width: 60,
              height: 60,
              placeholder: AssetImage(AppImages.duserImage),
              image: const NetworkImage(
                'https://media-exp1.licdn.com/dms/image/C4D03AQHuILHolmwcsw/profile-displayphoto-shrink_200_200/0/1635605885835?e=2147483647&v=beta&t=QPucLhzpuEWgVZbpTislGr8cr8wtfyeuumpE0jGH9MM',
              ),
            ),
          ),
        ),
        TextView(
          text: translate('Ahamed Raaft'),
          colorText: AppColor.txtColor4,
          sizeText: 16,
          weightText: FontWeight.w700,
          padding: const EdgeInsets.all(4),
          textAlign: TextAlign.start,
        ),
        AuthButton(
          buttonText: 'send',
          width: 100,
          onPressed: () {},
          colors: [
            AppColor.darkBlue,
            AppColor.lightBlue,
          ],
        )
      ],
    );
  }

  Row _teachers(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.all(4),
          width: 60,
          height: 60,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: FadeInImage(
              fit: BoxFit.cover,
              width: 60,
              height: 60,
              placeholder: AssetImage(AppImages.duserImage),
              image: const NetworkImage(
                'https://media-exp1.licdn.com/dms/image/C4D03AQHuILHolmwcsw/profile-displayphoto-shrink_200_200/0/1635605885835?e=2147483647&v=beta&t=QPucLhzpuEWgVZbpTislGr8cr8wtfyeuumpE0jGH9MM',
              ),
            ),
          ),
        ),
        TextView(
          text: translate('Ahamed Raaft'),
          colorText: AppColor.txtColor4,
          sizeText: 16,
          weightText: FontWeight.w700,
          padding: const EdgeInsets.all(4),
          textAlign: TextAlign.start,
        ),
        Checkbox(
            value: list.contains(index),
            onChanged: (val) {
              setState(() {
                if (val ?? false) {
                  list.add(index);
                } else {
                  list.remove(index);
                }
              });
            }),
      ],
    );
  }
}
