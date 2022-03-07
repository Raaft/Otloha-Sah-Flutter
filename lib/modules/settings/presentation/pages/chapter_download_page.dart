import 'package:flutter/material.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/alert_dialog_full_screen.dart';
import 'package:flutter_base/core/widgets/loading.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/settings/presentation/pages/narration_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/reciters_page.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/item_download.dart';
import 'package:flutter_base/modules/settings/business_logic/chapter/chapter_cubit.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

class ChapterDownloadPage extends StatefulWidget {
  const ChapterDownloadPage({Key? key}) : super(key: key);
  static const routeName = '/quran/download-center';

  @override
  State<ChapterDownloadPage> createState() => _ChapterDownloadPageState();
}

class _ChapterDownloadPageState extends State<ChapterDownloadPage> {
  int _selected = -1;
  final List<int> _downloaded = [];

  String? narrationName;
  String? bookName;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChapterCubit>(context).fetchChaptersList();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      narrationName = await CacheHelper.getData(key: 'NarrationsSelectedName');
      bookName = await CacheHelper.getData(key: 'BookSelectedName');
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [_topView(), _viewItems()],
        ),
      ),
    );
  }

  Widget _topView() {
    return SearchBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: 'Download Center',
      onSearch: (val) {
        BlocProvider.of<ChapterCubit>(context).fetchChaptersList(qurey: val);
        _selected = -1;
      },
    );
  }

  Widget _viewItems() {
    return BlocBuilder<ChapterCubit, ChapterState>(
      builder: (context, state) {
        if (state is ChapterFetched) {
          return _viewData(state.chapters);
        } else if (state is ChapterInitial) {
          return const LoadingWidget();
        } else if (state is ChapterEmpty) {
          Future.delayed(const Duration(seconds: 3), () {
            if (state.isNarrtion) {
              Navigator.of(context)
                  .pushReplacementNamed(NarrationPage.routeName)
                  .then((value) {
                BlocProvider.of<ChapterCubit>(context).fetchChaptersList();
              });
            } else {
              Navigator.of(context)
                  .pushReplacementNamed(RecitersPage.routeName)
                  .then((value) {
                BlocProvider.of<ChapterCubit>(context).fetchChaptersList();
              });
            }
          });
          return Expanded(
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: AppColor.lightBlue,
                    size: 150,
                  ),
                  TextView(
                      text:
                          'You must Choose ${state.isNarrtion ? 'Narrtation' : 'Reciter'} First'),
                ],
              ),
            ),
          );
        } else {
          return _viewData(
            null,
            isDemo: true,
          );
        }
      },
    );
  }

  Expanded _viewData(List<Chapter>? chapters, {bool isDemo = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return ItemDownload(
              name: isDemo ? 'chapters name' : chapters![index].name.toString(),
              description: '$narrationName \n$bookName',
              isDownloaded: _downloaded.contains(index),
              isSelect: _selected == index,
              onLongPress: () {
                if (_downloaded.contains(index)) {
                  Get.dialog(
                    const AlertDialogFullScreen(),
                    barrierColor: AppColor.backdone,
                  );
                  setState(() {
                    _selected = index;
                  });
                }
              },
              onDownload: () {
                setState(() {
                  _downloaded.add(index);
                });
              },
              action: () {
                if (_downloaded.contains(index)) {
                  Get.dialog(
                    const AlertDialogFullScreen(),
                    barrierColor: AppColor.backdone,
                  );
                  setState(() {
                    _selected = index;
                  });
                }
              },
            );
          },
        ),
      ),
    );
  }
}
