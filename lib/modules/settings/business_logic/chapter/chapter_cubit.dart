import 'package:bloc/bloc.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';
part 'chapter_state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  Recitation? recitation;

  ChapterCubit() : super(ChapterInitial());

  fetchChaptersList({
    String? qurey,
    bool isSelect = false,
    bool? fromIndex,
  }) {
    try {
      int? narrationId = CacheHelper.getData(key: narrationSelectedId) as int?;
      int? bookId = CacheHelper.getData(key: bookSelectedId) as int?;
      int? reciterId = CacheHelper.getData(key: reciterSelectedId) as int?;

      if (isSelect || (narrationId != null && reciterId != null)) {
        DataSource.instance
            .fetchChaptersList(
          qurey: qurey,
          bookId: bookId,
          fromIndex: fromIndex,
          narrationId: narrationId,
        )
            .then((value) async {
          if (value!.isNotEmpty) {
            DataSource.instance
                .fetchRecitationsList(
                    reciterId: reciterId, narrationId: narrationId)
                .then((recitations) {
              recitation = recitations!.firstWhere((element) =>
                  (element.narrationId == narrationId &&
                      element.reciterId == reciterId));
              if (recitation != null) {
                emit(ChapterInitial());
                emit(ChapterFetched(value));
              } else {
                emit(const ChapterError('Not Found Data'));
              }
            });

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
