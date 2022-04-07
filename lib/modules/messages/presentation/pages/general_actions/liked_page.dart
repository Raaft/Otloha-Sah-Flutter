import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/constant/utils.dart';
import '../../../../../core/utils/res/images_app.dart';
import '../../../../settings/presentation/widgets/search_bar_app.dart';
import '../../../../settings/presentation/widgets/user_like.dart';

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
    return SearchBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
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
              ///dismissFun: GetUserQuranActionCubit.get(context).deleteVerseLiked(id),
              userName: 'User Name',
              userImage: AppImages.duserImage,
              note: (arg == 1) ? tr('user note her') : null,
            );
          },
        ),
      ),
    );
  }
}
