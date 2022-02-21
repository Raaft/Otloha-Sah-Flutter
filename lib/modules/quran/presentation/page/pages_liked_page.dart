import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/show_search.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/home/presentation/pages/home/home_page.dart';
import 'package:flutter_base/modules/quran/business_logic/cubit/getuserquranaction_cubit.dart';
import 'package:flutter_base/modules/quran/presentation/widget/note_item_view.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/user_like.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PagesLikedPage extends StatelessWidget {
  const PagesLikedPage({
    Key? key,
    this.arg,
  }) : super(key: key);

  static const routeName = '/quran/liked';

  final int? arg;

  @override
  Widget build(BuildContext context) {
    if (arg == 1) {
      BlocProvider.of<GetUserQuranActionCubit>(context).findAllVerseNotes();
    }
    if (arg == 2) {
      BlocProvider.of<GetUserQuranActionCubit>(context).findAllPageMarkeds();
    }
    if (arg == 3) {
      BlocProvider.of<GetUserQuranActionCubit>(context).findAllVerseLikeds();
    }
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
        onPressed: () {
          show(context);
        },
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
        child: BlocBuilder<GetUserQuranActionCubit, GetUserQuranActionState>(
          builder: (context, state) {
            if (state is GetUserQuranActionLikeds) {
              return ListView.builder(
                itemCount: state.verses.length,
                itemBuilder: (context, index) {
                  var verse = state.verses[index];
                  return _itemBuild(verse.textFristVerse ?? '', null, () {
                    Scaffold.of(context).showBottomSheet(
                      (context) => NoteItemView(
                        arg == 1,
                      ),
                      backgroundColor: AppColor.transparent,
                    );
                  });
                },
              );
            }
            if (state is GetUserQuranActionNotes) {
              return ListView.builder(
                itemCount: state.verses.length,
                itemBuilder: (context, index) {
                  var verse = state.verses[index];
                  return _itemBuild(verse.textFristVerse ?? '', verse.noteText,
                      () {
                    Scaffold.of(context).showBottomSheet(
                      (context) => NoteItemView(
                        arg == 1,
                        note: verse.noteText ?? '',
                      ),
                      backgroundColor: AppColor.transparent,
                    );
                  });
                },
              );
            }
            if (state is GetUserQuranActionMarks) {
              return ListView.builder(
                itemCount: state.pages.length,
                itemBuilder: (context, index) {
                  var page = state.pages[index];
                  return _itemBuild(page.text ?? '', null, () {
                    Navigator.of(context).pushReplacementNamed(
                      HomePage.routeName,
                      arguments: 1,
                    );
                  });
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppIcons.addIcon,
                      height: 150,
                      width: 150,
                    ),
                    const TextView(text: 'No Data go to Add First!'),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _itemBuild(
    String name,
    String? note,
    Function() action,
  ) {
    return UserLiked(
        userName: name,
        userImage: AppIcons.quran2Icon,
        note: note,
        action: action);
  }
}
