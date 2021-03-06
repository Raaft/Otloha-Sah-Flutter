import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/constant/utils.dart';
import '../../../../../core/utils/res/images_app.dart';
import '../../widgets/box_message_item.dart';
import '../../../../settings/presentation/widgets/search_bar_app.dart';

class NotifiactionsPage extends StatelessWidget {
  const NotifiactionsPage({Key? key}) : super(key: key);
  static const routeName = '/notify';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [_topView(context), _viewItems()],
        ),
      ),
    );
  }

  Expanded _viewItems() {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              return _itemView(index);
            },
          )),
    );
  }

  Widget _itemView(int index) {
    return BoxMessageItem(
      id: 1,
      isRead: ((index % 3) == 0),
      ayah: tr('Notifiaction contant'),
      ayahInfo: '',
      userImage: AppImages.duserImage,
      userName: 'Mohamed Ahmed',
      dateStr: '9:30 15 Nov',
    );
  }

  Widget _topView(BuildContext context) {
    return SearchBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: translate('Notifiactions'),
    );
  }
}
