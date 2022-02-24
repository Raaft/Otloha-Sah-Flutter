import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_from_fielid.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/home/data/models/utils/init_data.dart';
import 'package:flutter_base/modules/quran/presentation/widget/item_surah.dart';
import 'package:flutter_base/modules/settings/presentation/pages/books_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/chapter_download_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/narration_page.dart';
import 'package:flutter_base/modules/teachers/presentation/widgets/item_teacher.dart';

class SearchBNBPage extends StatefulWidget {
  const SearchBNBPage({Key? key}) : super(key: key);

  @override
  State<SearchBNBPage> createState() => _SearchBNBPageState();
}

class _SearchBNBPageState extends State<SearchBNBPage> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _topView(context),
        _searchBox(),
        _getSearchTarget(),
        _viewItems()
      ],
    );
  }

  Widget _searchBox() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormFieldApp(
                title: 'title',
                validator: (val) {
                  return null;
                },
                onSaved: (val) {},
                color: AppColor.txtColor3,
              ),
            ),
            if (_selected == 0)
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    _showFilter();
                  },
                  child: Image.asset(
                    AppIcons.filterIcon,
                    height: 30,
                    width: 30,
                    color: AppColor.lightBlue,
                  ),
                ),
              ),
          ],
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
            if (_selected == 1) {
              return ItemTeacher(
                userName: 'Teacher Name',
                rate: '3.4',
                userId: 'User202Team',
                userbio:
                    'Proident duis sint pariatur aliquip nostrud Lorem velit tempor duis amet mollit.',
                action: () {},
                typeView: true,
                isCertified: index % 3 == 0,
              );
            }
            if (_selected == 2) {
              return ItemTeacher(
                userName: 'Students Name',
                rate: '3.4',
                userId: 'User202Team',
                userbio:
                    'Proident duis sint pariatur aliquip nostrud Lorem velit tempor duis amet mollit.',
                action: () {},
                typeView: true,
                isCertified: index % 3 == 0,
              );
            } else {
              return ItemSurah(
                name: 'Al-Fatihah',
                partName: 'juz 1',
                pageFrom: 1,
                pageTO: 1,
                verses: 7,
                isMakkah: index % 2 == 0,
                isSelect: false,
                onLongPress: () {},
              );
            }
          },
        ),
      ),
    );
  }

  Widget _topView(BuildContext context) {
    return ToolBarApp(
      title: translate('Search'),
    );
  }

  Widget _getSearchTarget() {
    return SizedBox(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _itemSearchTarget(index,
              (index == 0) ? translate('Quran') : subSectionData[index].title);
        },
        itemCount: subSectionData.length,
      ),
      height: 56,
    );
  }

  _itemSearchTarget(int index, String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColor.borderColor,
            width: 1,
          ),
          color:
              (index == _selected) ? AppColor.borderColor : AppColor.conColor2,
        ),
        child: TextView(
          text: name,
          colorText: AppColor.txtColor3,
          sizeText: 16,
          weightText: FontWeight.bold,
        ),
      ),
    );
  }

  void _showFilter() {
    Scaffold.of(context).showBottomSheet((context) {
      return SizedBox(
        height: 250,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              child: Divider(thickness: 3),
              width: 200,
            ),
            const TextView(text: 'Setect Filter'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ChapterDownloadPage.routeName);
              },
              child: const TextView(text: 'By Chapter'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NarrationPage.routeName);
              },
              child: const TextView(text: 'By Narration'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(BooksPage.routeName);
              },
              child: const TextView(text: 'By Book'),
            ),
          ],
        ),
      );
    });
  }
}
