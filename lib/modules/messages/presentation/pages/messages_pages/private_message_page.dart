import 'package:flutter/material.dart';
import '../../../../../core/utils/res/images_app.dart';
import '../../widgets/item_user_messages.dart';

class PrivateMessagePage extends StatelessWidget {
  const PrivateMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return _getItem(index);
          },
        ),
      ),
    );
  }

  Widget _getItem(int index) {
    return UserMessageIetm(
      lastMsg: 'أن الذين كفروا سواء عليهم',
      userImage: AppImages.duserImage,
      userName: 'Mohamed Ahmed',
      lastDate: '9:30 15 Nov',
    );
  }
}
