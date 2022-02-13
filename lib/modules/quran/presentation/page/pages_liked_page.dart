import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/home/presentation/pages/home/home_page.dart';
import 'package:flutter_base/modules/quran/presentation/widget/note_item_view.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/user_like.dart';

class PagesLikedPage extends StatelessWidget {
  const PagesLikedPage({
    Key? key,
    this.arg,
  }) : super(key: key);

  static const routeName = '/quran/liked';

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
      title: (arg == 2)
          ? translate('BookMarks')
          : (arg == 1)
              ? translate('Note')
              : translate('Likes'),
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
              userName: 'Page # 12',
              userImage: AppIcons.quran2Icon,
              note: (arg == 1) ? 'user note' : null,
              action: () {
                if (arg == 2) {
                  Navigator.of(context)
                      .pushReplacementNamed(HomePage.routeName, arguments: 1);
                } else {}
                Scaffold.of(context).showBottomSheet(
                  (context) => NoteItemView(
                    arg == 1,
                    isAdd: true,
                  ),
                  backgroundColor: AppColor.transparent,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
