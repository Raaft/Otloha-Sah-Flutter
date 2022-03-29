import 'package:dio/dio.dart';
import 'package:flutter_base/data_source/models/message_model/general_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'pagination_state.dart';

final factories = <Type, Function>{
  GeneralResponse: (Map<String, dynamic> data) =>
      GeneralResponse.fromJson(data),
};

class PaginationCubit<T> extends Cubit<PaginationState> {
  final String linkFrist;
  final Future<Response> Function() getData;

  PagingController<String, T>? _pagingController;

  PaginationCubit(this.linkFrist, this.getData) : super(PaginationInitial()) {
    _pagingController = PagingController(firstPageKey: linkFrist);
    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  get pagingController => _pagingController;

  Future<void> _fetchPage(String? pageKey) async {
    try {
      Response response = await getData();

      final isLastPage = (response.data['next'] != null &&
          response.data['next'].toString().isNotEmpty);

      var itemsNew = factories[T]!(response.data['results']);
      if (isLastPage) {
        _pagingController?.appendLastPage(itemsNew);
      } else {
        final nextPageKey = response.data['next'];
        _pagingController?.appendPage(itemsNew, nextPageKey);
      }
    } catch (error) {
      _pagingController!.error = error;
    }
  }

  static PaginationCubit get(context) => BlocProvider.of(context);
}
