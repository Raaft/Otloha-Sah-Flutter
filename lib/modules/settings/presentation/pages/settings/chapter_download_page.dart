import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../data_source/cache_helper.dart';
import '../../../../../core/utils/constant/constants.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../../../core/widgets/alert_dialog_full_screen.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/text_view.dart';
import 'narration_page.dart';
import 'reciters_page.dart';
import '../../widgets/item_download.dart';
import '../../../business_logic/chapter/chapter_cubit.dart';
import '../../widgets/search_bar_app.dart';
import '../../widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:quran_widget_flutter/data_source/local/local_data_source/chapter_download_data_source.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

import '../../../../../data_source/enums/download_types.dart';

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

  Future<bool> isDownloaded(int id) async {
    return await ChapterDownloadLocalDataSource()
        .fetchChapterDownloadsById(id)
        .then((value) {
      return value == null ? false : value.downloaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      narrationName = await CacheHelper.getData(key: narrationSelectedName);
      bookName = await CacheHelper.getData(key: bookSelectedName);
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
      title: tr('Download Center'),
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
        }
        else if (state is ChapterInitial) {
          return const LoadingWidget();
        }
        else if (state is ChapterEmpty) {
          return _viewEmpty(state, context);
        }
        else {
          String error = tr('Not Found Data');

          if (state is ChapterError) {
            error = state.error;
          }

          return ViewError(error: error);
        }
      },
    );
  }

  Widget _viewEmpty(ChapterEmpty state, BuildContext context) {
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber,
              color: AppColor.lightBlue,
              size: 150,
            ),
            TextView(
                text:
                //    'You must Choose ${state.isNarrtion ? 'Narrtation' : 'Reciter'} First'

            tr('You must Choose')+ ((state.isNarrtion)?tr('Narrtation') : tr('Reciter'))+tr('First')),
          ],
        ),
      ),
    );
  }

  Expanded _viewData(List<Chapter>? chapters, {bool isDemo = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return FutureBuilder<bool>(
                future: isDownloaded(chapters![index].id!),
                builder: (context, snapshot) {
                  return ItemDownload(
                    instance: chapters[index],
                    downloadType: DownloadTypes.chapter,
                    name: isDemo
                        ? 'chapters name'
                        : chapters[index].name.toString(),
                    description: '${narrationName ?? ""} \n${bookName ?? ""}',
                    isDownloaded:
                        snapshot.connectionState == ConnectionState.done
                            ? snapshot.data!
                            : false,
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
                });
          },
        ),
      ),
    );
  }
}
