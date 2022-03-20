import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/data/model/verse_note.dart';
import 'package:flutter_base/modules/data/repository/database_repository.dart';

class AddNote extends StatefulWidget {
  const AddNote({
    Key? key,
    required this.title,
    this.idFromVerse,
    this.idToVerse,
    this.idPage,
    this.pageNumber,
    this.textFristVerse,
  }) : super(key: key);

  final String title;
  final int? idFromVerse;
  final int? idToVerse;
  final int? idPage;
  final int? pageNumber;
  final String? textFristVerse;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextDirection textDirection = TextDirection.rtl;

  final TextEditingController con = TextEditingController();

  get borderSide => BorderSide(width: 1, color: AppColor.lightBlue);

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: double.infinity,
          color: Colors.black54.withOpacity(.5),
        ),
        Container(
          height: 300,
          margin: const EdgeInsets.only(top: 40),
          color: AppColor.background1,
          child: Stack(
            children: [
              _viewTop(context),
              _viewPage(context),
            ],
          ),
        ),
      ],
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
          child: TextField(
              controller: con,
              decoration: InputDecoration(
                //  color: Colors.blue,
                // isDense: true,
                contentPadding: const EdgeInsets.all(12),
                filled: true,
                enabledBorder: border,
                focusedBorder: border,
                errorBorder: border,
                focusedErrorBorder: border,
                disabledBorder: border,

                hintText: translate('AddNote'),
                fillColor: AppColor.white,
              ),
              textAlign: TextAlign.start,
              textDirection: textDirection,
              onChanged: (val) {
                print(val);
                RegExp expEn = RegExp('[a-zA-Z]');

                if (expEn.hasMatch(val.substring(val.length - 1)) &&
                    val.substring(val.length - 1) != " ") {
                  setState(() {
                    textDirection = TextDirection.ltr;
                  });
                } else if (val.substring(val.length - 1) != " " &&
                    !expEn.hasMatch(val.substring(val.length - 1))) {
                  setState(() {
                    textDirection = TextDirection.rtl;
                  });
                }
                print(expEn.hasMatch(val.substring(val.length - 1)).toString());
              }),
        ));
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: widget.title,
                        textAlign: TextAlign.center,
                        colorText: AppColor.txtColor2,
                        sizeText: 17,
                      ),
                      Icon(
                        Icons.expand_more,
                        color: AppColor.txtColor2,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => _saveNote(context),
                    icon: Icon(
                      Icons.done_all,
                      color: AppColor.txtColor2,
                    ),
                  )
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

  void _saveNote(BuildContext context) {
    var note = con.text;
    if (note.isNotEmpty) {
      DatabaseRepository()
          .insertVerseNote(
            VerseNote(
              idFromVerse: widget.idFromVerse,
              idPage: widget.idPage,
              idToVerse: widget.idToVerse,
              pageNumber: widget.pageNumber,
              textFristVerse: widget.textFristVerse,
              noteText: note,
            ),
          )!
          .then((value) => Navigator.of(context).pop());
    } else {
      print('Non Text');
    }
  }
}
