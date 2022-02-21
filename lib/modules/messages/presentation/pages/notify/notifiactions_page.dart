import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/widgets/show_search.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/box_message_item.dart';

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
      isActive: ((index % 3) == 0),
      ayah: 'Notifiaction contant',
      ayahInfo: '',
      userImage: AppImages.duserImage,
      userName: 'Mohamed Ahmed',
      dateStr: '9:30 15 Nov',
    );
  }

  Widget _topView(BuildContext context) {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actionIcon: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              show(context);
            },
          ),
        ],
      ),
      title: translate('Notifiactions'),
    );
  }
}
