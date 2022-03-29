import 'package:flutter/material.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';

class NoteItemView extends StatelessWidget {
  const NoteItemView(this.isNote,
      {this.isAdd = false, Key? key, this.isQuranPage = false, this.note})
      : super(key: key);

  final bool isNote;
  final String? note;
  final bool isQuranPage;
  final bool isAdd;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!isNote)
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: AppColor.txtColor5,
                  size: 40,
                ),
              ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColor.background,
                  borderRadius: BorderRadius.circular(12)),
              child: const TextView(
                text: 'Ayaha',
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
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.delete,
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
