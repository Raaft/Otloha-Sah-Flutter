import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/home/presentation/widget/progressindicator.dart';

class UserProgressReading extends StatelessWidget {
  const UserProgressReading(
      {Key? key, required this.userProgressIndicator, this.action})
      : super(key: key);

  final UserProgressIndicator userProgressIndicator;

  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.gradient1, AppColor.gradient2],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            userProgressIndicator,
            const SizedBox(width: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                AppIcons.quranIcon,
                width: 32,
                height: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
