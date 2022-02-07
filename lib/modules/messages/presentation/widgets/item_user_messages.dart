import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

class UserMessageIetm extends StatelessWidget {
  const UserMessageIetm({
    Key? key,
    required this.userName,
    required this.userImage,
    required this.lastMsg,
    required this.lastDate,
  }) : super(key: key);

  final String userName;
  final String userImage;
  final String lastMsg;
  final String lastDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.backItem,
      elevation: 0,
      margin: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Image.asset(userImage),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextView(
                    text: userName,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    sizeText: 16,
                    weightText: FontWeight.bold,
                    textAlign: TextAlign.start,
                    colorText: AppColor.txtColor3,
                  ),
                  TextView(
                    text: lastMsg,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    colorText: AppColor.txtColor4,
                    sizeText: 16,
                    textAlign: TextAlign.start,
                  ),
                  TextView(
                    text: lastDate,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    colorText: AppColor.txtColor4,
                    sizeText: 16,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
