import 'package:flutter/material.dart';
import '../../../../../core/utils/constant/utils.dart';
import '../../../../../core/utils/res/icons_app.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../../../core/widgets/text_view.dart';
import '../../../../../data_source/models/database_model/page_marked.dart';
import '../../../../home/presentation/pages/home/home_page.dart';
import '../../../business_logic/cubit/getuserquranaction_cubit.dart';
import '../../../../settings/presentation/widgets/search_bar_app.dart';
import '../../../../settings/presentation/widgets/user_like.dart';
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
    return SearchBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
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
                    Navigator.of(context).pushReplacementNamed(
                      HomePage.routeName,
                      arguments: 1,
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
                    Navigator.of(context).pushReplacementNamed(
                      HomePage.routeName,
                      arguments: 1,
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
                  return _itemBuild(page.textVerse ?? '', null, () {
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
      action: action,
    );
  }
}

class PagesBookMarkPage extends StatelessWidget {
  const PagesBookMarkPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/quran/bookmark';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetUserQuranActionCubit>(context).findAllPageMarkeds();
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
        title: translate('BookMarks'));
  }

  Expanded _viewItems() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetUserQuranActionCubit, GetUserQuranActionState>(
          builder: (context, state) {
            if (state is GetUserQuranActionMarks) {
              return ListView.builder(
                itemCount: state.pages.length,
                itemBuilder: (context, index) {
                  late PageMarked page = state.pages[index];
                  return ItemBookMark(
                      name: page.textVerse.toString(),
                      pageFrom: page.idPage!.toInt(),
                      onPress: () {
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
}

class ItemBookMark extends StatelessWidget {
  const ItemBookMark({
    Key? key,
    required this.name,
    required this.pageFrom,
    required this.onPress,
    this.action,
    this.isSelect = false,
  }) : super(key: key);

  final String name;
  final int pageFrom;

  final bool isSelect;
  final Function() onPress;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelect ? AppColor.borderColor : AppColor.conColor2,
            width: 1,
          ),
          color: AppColor.conColor2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppIcons.quran3Icon,
              width: 32,
              height: 32,
            ),
            TextView(
              text: name,
              colorText: AppColor.txtColor3,
              sizeText: 16,
              weightText: FontWeight.bold,
            ),
            const Spacer(),
            TextView(
              text: '${translate('Page')} $pageFrom ',
              colorText: AppColor.txtColor4,
              sizeText: 12,
            ),
/*             TextView(
              text: '${translate('Verses')}  $verses',
              colorText: AppColor.txtColor4,
              sizeText: 12,
            ),
/* */            TextView(
              text: partName,
              colorText: AppColor.txtColor4,
              sizeText: 12,
            ),
/* */            Image.asset(
              isMakkah ? AppIcons.makkahIcon : AppIcons.medinaIcon,
              width: 28,
              height: 28,
            ),
 */
          ],
        ),
      ),
    );
  }
}
