import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:flutter_base/core/pagination/cubit/pagination_cubit.dart';

class PaginationData<T> extends StatelessWidget {
  PaginationData({
    Key? key,
    required this.drowItem,
  }) : super(key: key);

  final Function(T, int) drowItem;

  PaginationCubit<T>? _cubit;
  @override
  Widget build(BuildContext context) {
    _cubit = PaginationCubit.get(context) as PaginationCubit<T>?;
    return PagedListView<String, T>(
      pagingController: _cubit!.pagingController,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: (context, item, index) => drowItem(item, index),
      ),
    );
  }
}
