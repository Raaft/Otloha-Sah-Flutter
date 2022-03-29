import 'package:dio/dio.dart';
import 'package:flutter_base/data_source/models/database_model/recitations.dart';
import 'package:flutter_base/data_source/models/database_model/teacher_response_entity.dart';
import '../../../data_source/models/message_model/general_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'pagination_state.dart';

final factories = <Type, Function>{
  GeneralResponse: (Map<String, dynamic> data) =>
      GeneralResponse.fromJson(data),
  Recitations: (Map<String, dynamic> data) => Recitations.fromJson(data),
  TeacherResponse: (Map<String, dynamic> data) =>
      TeacherResponse.fromJson(data),
};

class PaginationCubit<T> extends Cubit<PaginationState> {
  Future<Response> Function(int)? getData;
  List<T>? initData;
  bool isFirst = true;

  int page = 1;

  PagingController<int, T>? _pagingController;

  PaginationCubit() : super(PaginationInitial());

  setData(getData, initData) {
    this.getData = getData;
    this.initData = initData;
    page = 1;
    _pagingController = PagingController(firstPageKey: page);
    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  get pagingController => _pagingController;

  Future<void> _fetchPage(int? pageKey) async {
    try {
      if (isFirst) {
        _pagingController?.appendPage(initData!, page++);
        isFirst = false;
      } else {
        Response response = await getData!(pageKey!);

        final isLastPage = (response.data['next'] == null ||
            response.data['next'].toString().isEmpty);

        List<T> itemsNew = (response.data['results'] as List)
            .map<T>((e) => factories[T]!())
            .toList();
        if (isLastPage) {
          _pagingController?.appendLastPage(itemsNew);
          emit(state);
        } else {
          page++;
          _pagingController?.appendPage(itemsNew, page);
          emit(state);
        }
      }
    } catch (error) {
      _pagingController!.error = error;
      emit(state);
    }
  }

  static PaginationCubit get(context, {bool listen = true}) =>
      BlocProvider.of(context);
}
