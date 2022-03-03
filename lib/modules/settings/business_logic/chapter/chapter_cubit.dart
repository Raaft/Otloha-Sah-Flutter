import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';
part 'chapter_state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  ChapterCubit() : super(ChapterInitial());

  fetchChaptersList({String? qurey, bool isSelect = false}) {
    try {
      int? narrationId = CacheHelper.getData(key: 'NarrationsSelected') as int?;
      int? reciterId = CacheHelper.getData(key: 'ReciterSelected') as int?;

      if (isSelect || (narrationId != null && reciterId != null)) {
        DataSource.instance.fetchChaptersList(qurey: qurey).then((value) async {
          if (value!.isNotEmpty) {
            emit(ChapterInitial());
            emit(ChapterFetched(value));
          } else {
            emit(const ChapterError('Not Found Data'));
          }
        });
      } else {
        if (narrationId == null) {
          emit(const ChapterEmpty(true));
        } else {
          emit(const ChapterEmpty(false));
        }
      }
    } catch (e) {
      emit(ChapterError(e.toString()));
    }
  }
}
