import 'package:flutter/material.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';
import '../../../auth_module/business_logic/auth_cubit.dart';
import 'progressindicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


///////////commit
class HomeMainSection extends StatelessWidget {
  const HomeMainSection({
    Key? key,
    required this.title,
    required this.image,
    required this.gradient1,
    required this.gradient2,
    required this.userProgressIndicator,
    this.action,
  }) : super(key: key);

  final String title;
  final String image;
  final Color gradient1;
  final Color gradient2;

  final UserProgressIndicator userProgressIndicator;

  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: action,
        child: Container(
          height: MediaQuery.of(context).size.height * .23,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradient1, gradient2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    image,
                    width: MediaQuery.of(context).size.width * .125,
                    height: MediaQuery.of(context).size.width * .125,
                  ),
                  GestureDetector(
                      onTap: () {}, child: const Icon(Icons.arrow_forward))
                ],
              ),
              //const SizedBox(height: 16),
              Expanded(
                child: Center(
                  child: TextView(
                    text: title,
                    colorText: AppColor.txtColor3,
                    sizeText: 16,
                    weightText: FontWeight.w700,
                    padding: const EdgeInsets.all(0),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                var cubit=AuthCubit.get(context);
                return (cubit.isLogin)
                    ? userProgressIndicator
                    : const Text('');
              })
            ],
          ),
        ),
      ),
    );
  }
}
