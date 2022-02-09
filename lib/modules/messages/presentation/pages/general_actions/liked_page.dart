import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/user_like.dart';

class LikedPage extends StatelessWidget {
  const LikedPage({
    Key? key,
    this.arg,
  }) : super(key: key);

  static const routeName = '/message/liked';

  final int? arg;

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

  Widget _topView(BuildContext context) {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actionIcon: IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {},
      ),
      title: translate('Users'),
    );
  }

  Expanded _viewItems() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return UserLiked(
              userName: 'User Name',
              userImage: AppImages.duserImage,
              note: (arg == 1) ? 'user note hir' : null,
            );
          },
        ),
      ),
    );
  }
}
