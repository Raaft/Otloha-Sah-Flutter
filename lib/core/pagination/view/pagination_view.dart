import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/data_source/models/database_model/recitations.dart';
import 'package:flutter_base/data_source/models/database_model/teacher_response_entity.dart';
import 'package:flutter_base/data_source/models/message_model/general_response.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

final factories = <Type, Function>{
  GeneralResponse: (Map<String, dynamic> data) =>
      GeneralResponse.fromJson(data),
  Recitations: (Map<String, dynamic> data) => Recitations.fromJson(data),
  TeacherResponse: (Map<String, dynamic> data) =>
      TeacherResponse.fromJson(data),
};

class PaginationData<T> extends StatefulWidget {
  const PaginationData({
    Key? key,
    required this.getData,
    required this.drowItem,
    required this.initData,
  }) : super(key: key);

  final List<T> initData;

  final Future<Response> Function(int) getData;
  final Function(T, int) drowItem;

  @override
  State<PaginationData<T>> createState() => _PaginationDataState<T>();
}

class _PaginationDataState<T> extends State<PaginationData<T>> {
  final PagingController<int, T> _pagingController =
      PagingController(firstPageKey: 0);

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
      if (isFirst) {
        _pagingController.appendPage(widget.initData, page++);
        isFirst = false;
      } else {
        Response response = await widget.getData(pageKey!);

        final isLastPage = (response.data['next'] == null ||
            response.data['next'].toString().isEmpty);

        List<T> itemsNew = (response.data['results'] as List)
            .map<T>((map) => factories[T]!(map))
            .toList();
        if (isLastPage) {
          _pagingController.appendLastPage(itemsNew);
        } else {
          page++;
          _pagingController.appendPage(itemsNew, page);
        }
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('PaginationData ' + T.toString() + ' ' + widget.initData.toString());
    return PagedListView<int, T>(
      shrinkWrap: true,
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: (context, item, index) => widget.drowItem(item, index),
      ),
    );
  }
}
