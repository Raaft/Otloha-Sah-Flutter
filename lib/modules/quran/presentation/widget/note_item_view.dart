import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';

import '../../../../data_source/models/database_model/verse_note.dart';
import '../../business_logic/cubit/getuserquranaction_cubit.dart';

class NoteItemView extends StatelessWidget {
  const NoteItemView(
      {required this.isNote,
      this.isAdd = false,
      Key? key,
      this.isQuranPage = false,
      this.note,
      this.verse,
      required this.cubit,
      required this.verseNote})
      : super(key: key);

  final bool isNote;
  final String? note;
  final String? verse;
  final bool isQuranPage;
  final bool isAdd;
  final GetUserQuranActionCubit cubit;
  final VerseNote verseNote;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * .75),
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        color: AppColor.transparent,
        child: Stack(
          children: [
            if (isQuranPage == false) _viewTop(context),
            _viewPage(context),
          ],
        ),
      ),
    );
  }

  Widget _viewPage(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            color: Colors.white),
        child: ListView(
        //  crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColor.background,
                  borderRadius: BorderRadius.circular(12)),
              child: TextView(
                text: verse!,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 40),
            if (isNote)
              TextView(
                text: note ?? '',
                textAlign: TextAlign.start,
              ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _viewTop(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            color: AppColor.darkBlue,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_sharp,
                      color: AppColor.txtColor2,
                    ),
                  ),
                  isAdd
                      ? IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.done_all,
                            color: AppColor.txtColor2,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            Get.bottomSheet(
                                EditeNoteItemView(
                                  isNote: isNote,
                                  cubit: cubit,
                                  verseNote: verseNote,
                                  note: verseNote.noteText,
                                ),
                                isScrollControlled: true);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: AppColor.txtColor2,
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EditeNoteItemView extends StatelessWidget {
  EditeNoteItemView(
      {required this.isNote,
      this.isAdd = false,
      Key? key,
      this.isQuranPage = false,
      this.note,
      this.verse,
      required this.cubit,
      required this.verseNote})
      : super(key: key);

  final bool isNote;
  final String? note;
  final String? verse;
  final bool isQuranPage;
  final bool isAdd;
  final GetUserQuranActionCubit cubit;
  final VerseNote verseNote;

  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    editingController.text = note ?? '';
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * .75),
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        color: AppColor.transparent,
        child: Stack(
          children: [
            if (isQuranPage == false) _viewTop(context),
            _viewPage(context),
          ],
        ),
      ),
    );
  }

  Widget _viewPage(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isNote)
              FormBuilderTextField(
                name: 'Edite',
                controller: editingController..text = note ?? '',
                //  initialValue:editingController.text ,
              ),
            // TextView(
            //   text: note ?? '',
            //   textAlign: TextAlign.start,
            // ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _viewTop(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            color: AppColor.darkBlue,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_sharp,
                      color: AppColor.txtColor2,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cubit
                          .updateVerseNotes(verseNote, editingController.text)
                          .then((value) {
                        cubit.findAllVerseNotes().then((value) {
                          Get.back();
                          Get.back();
                        });
                      });
                    },
                    icon: Icon(
                      Icons.done_outline,
                      color: AppColor.txtColor2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
