import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/exception_indicators/error_indicator.dart';
import 'package:flutter_base/data_source/models/database_model/recitations.dart';
import 'package:flutter_base/data_source/models/database_model/teacher_response_entity.dart';
import 'package:flutter_base/data_source/models/message_model/general_response.dart';
import 'package:flutter_base/data_source/models/message_model/message_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

final factories = <Type, Function>{
  GeneralResponse: (Map<String, dynamic> data) =>
      GeneralResponse.fromJson(data),
  Recitations: (Map<String, dynamic> data) => Recitations.fromJson(data),
  TeacherResponse: (Map<String, dynamic> data) =>
      TeacherResponse.fromJson(data),
  MessageModel: (Map<String, dynamic> data) => MessageModel.fromJson(data),
};

class PaginationData<T> extends StatefulWidget {
  const PaginationData({
    Key? key,
    this.initData,
    required this.getData,
    required this.drowItem,
  }) : super(key: key);

  final List<T>? initData;

  final Future<Response?>? Function(int) getData;
  final Widget Function(T, int) drowItem;

  @override
  State<PaginationData<T>> createState() => _PaginationDataState<T>();
}

class _PaginationDataState<T> extends State<PaginationData<T>> {
  final PagingController<int, T> _pagingController =
      PagingController(firstPageKey: 1);

  int page = 1;
  bool isFirst = true;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int? pageKey) async {
    try {
      Response? response = await widget.getData(pageKey!);

      print('response.data[\'results\'] ${response!.data['results']}');

      final isLastPage = (response.data['next'] == null ||
          response.data['next'].toString().isEmpty);

      List<T> itemsNew = (response.data['results'] as List)
          .map<T>((map) => factories[T]!(map))
          .toList();
      if (!isLastPage) {
        _pagingController.appendLastPage(itemsNew);
      } else {
        _pagingController.appendPage(itemsNew, page);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('PaginationData ' + T.toString() + ' ' + widget.initData.toString());
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () {
          page = 1;
          _pagingController.refresh();
        },
      ),
      child: PagedListView<int, T>(
        shrinkWrap: true,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<T>(
            itemBuilder: (context, item, index) => widget.drowItem(item, index),
            firstPageErrorIndicatorBuilder: (error) {
              return ErrorIndicator(
                error: _pagingController.error,
                onTryAgain: _pagingController.refresh,
              );
            }),
      ),
    );
  }

// @override
// void dispose() {
//   _pagingController.dispose();
//   super.dispose();
// }
}
