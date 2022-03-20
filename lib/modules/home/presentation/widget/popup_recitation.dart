import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

class PopupRecitation extends StatelessWidget {
  const PopupRecitation({
    Key? key,
    this.finish,
    this.general,
    this.delete,
    this.send,
    this.isGeneral = false,
  }) : super(key: key);

  final Function()? finish;
  final Function()? general;
  final Function()? delete;
  final Function()? send;
  final bool isGeneral;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (finish != null)
            ListTile(
              onTap: finish ?? () {},
              title: const TextView(
                  text: 'Mark as Finish', textAlign: TextAlign.start),
              leading: const Icon(Icons.mark_chat_read),
            ),
          if (general != null)
            ListTile(
              onTap: general ?? () {},
              title: const TextView(
                  text: 'Share to General', textAlign: TextAlign.start),
              leading: const Icon(Icons.share),
              trailing: Checkbox(
                  value: isGeneral,
                  onChanged: (val) {
                    general!();
                  }),
            ),
          if (send != null)
            ListTile(
              onTap: send ?? () {},
              title:
                  const TextView(text: 'Send to', textAlign: TextAlign.start),
              leading: Transform(
                  alignment: Alignment.center,
                  transform:
                      isEn ? Matrix4.rotationY(0) : Matrix4.rotationY(pi),
                  child: const Icon(Icons.send)),
            ),
          if (delete != null)
            ListTile(
              onTap: delete ?? () {},
              title: TextView(
                  text: 'Delete',
                  colorText: AppColor.txtColor5,
                  textAlign: TextAlign.start),
              leading: Icon(
                Icons.delete,
                color: AppColor.txtColor5,
              ),
            ),
        ],
      ),
    );
  }
}
