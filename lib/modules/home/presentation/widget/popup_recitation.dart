import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';

class PopupRecitation extends StatelessWidget {
  const PopupRecitation({
    Key? key,
    required this.finish,
    required this.general,
    required this.delete,
  }) : super(key: key);

  final Function() finish;
  final Function() general;
  final Function() delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthButton(
            buttonText: 'Mark as Finish',
            width: 100,
            onPressed: finish,
            colors: [
              AppColor.darkBlue,
              AppColor.lightBlue,
            ],
          ),
          AuthButton(
            buttonText: 'Share to General',
            width: 100,
            onPressed: general,
            colors: [
              AppColor.darkBlue,
              AppColor.lightBlue,
            ],
          ),
          AuthButton(
            buttonText: 'Delete',
            width: 100,
            onPressed: delete,
            colors: [
              AppColor.conColor4,
              AppColor.conColor4l,
            ],
          ),
        ],
      ),
    );
  }
}
