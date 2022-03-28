import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/widgets/loading.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

import 'package:flutter_base/data_source/cache_helper.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/settings/business_logic/book/book_cubit.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/item_download.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';

import '../../../../../data_source/enums/download_types.dart';

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
      _selected = (CacheHelper.getData(key: bookSelectedId) as int?) ?? -1;
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
          return const LoadingWidget();
        } else {
          String error = 'Not Found Data';

          if (state is BookError) {
            error = state.error;
          }

          return ViewError(error: error);
        }
      },
    );
  }

  Expanded _viewData(BookFetched? state) {
    List<Book>? booksDown = [];
    List<Book>? booksUp = [];
    for (var element in state!.books!) {
      if (element.downloaded ?? false) {
        booksDown.add(element);
      } else {
        booksUp.add(element);
      }
    }

    return Expanded(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        children: [
          if (booksDown.isNotEmpty)
            const TextView(
              text: 'Downloaded Books',
              textAlign: TextAlign.start,
            ),
          if (booksDown.isNotEmpty)
            _downloadedBooks(
              booksDown,
            ),
          if (booksUp.isNotEmpty && booksDown.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Divider(
                thickness: 1,
                color: AppColor.grey,
              ),
            ),
          if (booksUp.isNotEmpty)
            const TextView(
              text: 'Books Available for download ',
              textAlign: TextAlign.start,
            ),
          if (booksUp.isNotEmpty)
            _downloadBooks(
              booksUp,
            )
        ],
      ),
    );
  }

  ListView _downloadedBooks(List<Book>? books) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: books!.length,
      itemBuilder: (context, index) {
        return ItemDownload(
          instance: books[index],
          downloadType: DownloadTypes.page,
          name: books[index].name.toString(),
          isDownloaded: true,
          isSelect: _selected == index,
          action: () {
            BlocProvider.of<BookCubit>(context).changeIndex(index);
          },
        );
      },
    );
  }

  ListView _downloadBooks(
    List<Book>? books, {
    bool isDemo = false,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: isDemo ? 15 : books!.length,
      itemBuilder: (context, index) {
        return ItemDownload(
          instance: books![index],
          downloadType: DownloadTypes.page,
          name: isDemo ? 'books name' : books[index].name.toString(),
          isDownloaded: _downloaded.contains(index),
          isSelect: false,
          onDownload: () {
            setState(() {
              _downloaded.add(index);
            });
          },
          action: () {
            setState(() {
              _downloaded.add(index);
            });
          },
        );
      },
    );
  }
}
