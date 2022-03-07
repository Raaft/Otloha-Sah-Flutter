import 'package:flutter/material.dart';
import 'package:flutter_base/core/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/alert_dialog_full_screen.dart';
import 'package:flutter_base/modules/settings/business_logic/book/book_cubit.dart';
import 'package:flutter_base/modules/settings/data/models/init_data.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/item_download.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  static const routeName = '/settings/books';

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  int _selected = -1;

  final List<int> _downloaded = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookCubit>(context).fetchBooksList();
  }

  @override
  Widget build(BuildContext context) {
    try {
      _selected = (CacheHelper.getData(key: 'BookSelected') as int?) ?? -1;
    } catch (e) {
      debugPrint(e.toString());
    }
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
      title: 'Books Center',
      onSearch: (val) {
        BlocProvider.of<BookCubit>(context).fetchBooksList(qurey: val);
      },
    );
  }

  Widget _viewItems() {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, state) {
        if (state is BookFetched) {
          _selected = state.selected;
          if (state.books != null && state.books!.isNotEmpty) {
            return _viewData(state);
          } else {
            return const LoadingWidget();
          }
        } else if (state is BookInitial) {
          return _viewData(null, isDemo: true);
        } else {
          return _viewData(null, isDemo: true);
        }
      },
    );
  }

  Expanded _viewData(BookFetched? state, {bool isDemo = false}) {
    // var books = (state as BookFetched).books;
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        children: [
          _downloadedBooks(
            isDemo,
            isDemo ? null : state!.books!,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Divider(
              thickness: 1,
              color: AppColor.grey,
            ),
          ),
          _downloadBooks(
            isDemo,
            isDemo ? null : state!.books!,
          )
        ],
      ),
    );
  }

  ListView _downloadedBooks(bool isDemo, List<Book>? books) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: isDemo ? 15 : books!.length,
      itemBuilder: (context, index) {
        return ItemDownload(
          name: isDemo ? 'books name' : books![index].name.toString(),
          isDownloaded: true,
          isSelect: _selected == index,
          action: () {
            BlocProvider.of<BookCubit>(context).changeIndex(index, isDemo);
          },
        );
      },
    );
  }

  ListView _downloadBooks(bool isDemo, List<Book>? books) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: isDemo ? 15 : books!.length,
      itemBuilder: (context, index) {
        return ItemDownload(
          name: isDemo ? 'books name' : books![index].name.toString(),
          isDownloaded: _downloaded.contains(index),
          isSelect: false,
          onDownload: () {
            setState(() {
              _downloaded.add(index);
            });
          },
          onLongPress: () {
            setState(() {
              _selected = index;
            });
          },
          action: () {
            Get.dialog(
              const AlertDialogFullScreen(),
              barrierColor: AppColor.backdone,
            );
            setState(() {
              _selected = index;
            });

            CacheHelper.saveData(
                key: 'BookSelected', value: isDemo ? index : books![index].id);

            downLoadSettings[0].subTitle =
                isDemo ? 'Book name $index' : books![index].name;
            CacheHelper.saveData(
              key: 'BookSelectedName',
              value: isDemo ? 'Book name $index' : books![index].name,
            );
          },
        );
      },
    );
  }
}
