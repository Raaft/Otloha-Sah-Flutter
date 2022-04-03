import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_base/data_source/models/database_model/verse_note.dart';
import 'package:flutter_base/modules/quran/presentation/widget/note_item_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/constant/utils.dart';
import '../../../../../core/utils/res/icons_app.dart';
import '../../../../../core/widgets/text_view.dart';
import '../../../../settings/presentation/widgets/search_bar_app.dart';
import '../../../../settings/presentation/widgets/user_like.dart';
import '../../../business_logic/cubit/getuserquranaction_cubit.dart';

class PagesNotePage extends StatelessWidget {
  const PagesNotePage({
    Key? key,

    ///this.arg,
  }) : super(key: key);

  static const routeName = '/quran/note';

  //final int? arg;

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<GetUserQuranActionCubit>(context).findAllVerseNotes();

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
        title: translate('Note'));
  }

  Expanded _viewItems() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetUserQuranActionCubit, GetUserQuranActionState>(
          builder: (context, state) {
            if (state is GetUserQuranActionNotes) {



              return ListView.builder(
                itemCount: state.verses.length,
                itemBuilder: (context, index) {
                  var verse = state.verses[index];
                  return _itemBuild(
                    verse.textFristVerse ?? '',
                    verse.noteText,
                    () {
                      Get.bottomSheet(
                          NoteItemView(
                              verseNote: verse,
                              isNote: true,
                              note: verse.noteText,
                              verse: verse.textFristVerse,
                              cubit: BlocProvider.of<GetUserQuranActionCubit>(
                                  context)),
                          isScrollControlled: true);
                    },        BlocProvider.of<GetUserQuranActionCubit>(context)
                      ,verse
                  );
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

  Widget _itemBuild(String name, String? note, Function() action,
      GetUserQuranActionCubit cubit, VerseNote verseNote) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        UserLiked(
          userName: name,
          userImage: AppIcons.quran2Icon,
          note: note,
          action: action,
        ),
        IconButton(
            onPressed: () {
              cubit.deleteVerseNotes(verseNote.id ?? 1);
            },
            icon: Icon(Icons.delete_outline))
      ],
    );
  }
}
