import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/box_message_item.dart';

class InBoxMessagePage extends StatelessWidget {
  const InBoxMessagePage({Key? key}) : super(key: key);

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
    return BoxMessageItem(
      isActive: ((index % 3) == 0),
      ayah: 'أن الذين كفروا سواء عليهم',
      ayahInfo: 'Juz-1  6-Ayah البقرة',
      userImage: AppImages.duserImage,
      userName: 'Mohamed Ahmed',
      dateStr: '9:30 15 Nov',
    );
  }
}
