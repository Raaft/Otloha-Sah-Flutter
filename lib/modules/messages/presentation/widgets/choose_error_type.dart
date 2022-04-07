import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/data_source/models/message_model/error_type.dart';

class ChooseErrorType extends StatelessWidget {
  const ChooseErrorType({Key? key, required this.choosed}) : super(key: key);
  final Function(ErrorType) choosed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28), topRight: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextView(
            text: tr('Choose a Error Type'),
            colorText: AppColor.txtColor1,
            textAlign: TextAlign.start,
          ),
          ListTile(
            onTap: () {
              choosed(ErrorType.errors[0]);
            },
            title: TextView(
              text: ErrorType.errors[0].value ?? '',
              textAlign: TextAlign.start,
              colorText: AppColor.headTextColor,
            ),
            leading: Image.asset(
              ErrorType.errors[0].icon,
              width: 25,
              height: 25,
            ),
          ),
          ListTile(
            onTap: () {
              choosed(ErrorType.errors[1]);
            },
            title: TextView(
              text: ErrorType.errors[1].value ?? '',
              textAlign: TextAlign.start,
              colorText: AppColor.headTextColor,
            ),
            leading: Image.asset(
              ErrorType.errors[1].icon,
              width: 25,
              height: 25,
            ),
          ),
          ListTile(
            onTap: () {
              choosed(ErrorType.errors[2]);
            },
            title: TextView(
              text: ErrorType.errors[2].value ?? '',
              textAlign: TextAlign.start,
              colorText: AppColor.headTextColor,
            ),
            leading: Image.asset(
              ErrorType.errors[2].icon,
              width: 25,
              height: 25,
            ),
          ),
        ],
      ),
    );
  }
}
