import 'package:bloc/bloc.dart';
import '../../../../data_source/cache_helper.dart';
import '../../../../core/utils/constant/constants.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';
part 'chapter_state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  Recitation? recitation;

  ChapterCubit() : super(ChapterInitial());

  fetchChaptersList({String? qurey, bool isSelect = false}) {
    try {
      int? narrationId = CacheHelper.getData(key: narrationSelectedId) as int?;
      int? reciterId = CacheHelper.getData(key: reciterSelectedId) as int?;

      DataSource.instance.fetchChaptersList(qurey: qurey).then((value) async {
        if (value!.isNotEmpty) {
          if (isSelect) {
            emit(ChapterFetched(value));
            return;
          }
          if ((narrationId != null && reciterId != null)) {
            DataSource.instance
                .fetchRecitationsList(
                    reciterId: reciterId, narrationId: narrationId)
                .then((recitations) {
              if (recitations != null && recitations.isNotEmpty) {
                recitation = recitations.firstWhere(
                    (element) => (element.narrationId == narrationId &&
                        element.reciterId == reciterId),
                    orElse: () => Recitation(0, narrationId, reciterId, ''));
                if (recitation != null) {
                  //  emit(ChapterInitial());
                } else {
                  emit(const ChapterError('Not Found Data'));
                }
                (element) => (element._narrationId == narrationId &&
                    element.reciterId == reciterId);
              }
              if (recitation != null || recitation!.id == 0) {
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
        } else {
          if (narrationId == null) {
            emit(const ChapterEmpty(true));
          } else {
            emit(const ChapterEmpty(false));
          }
        }
      });
    } catch (e) {
      emit(ChapterError(e.toString()));
    }
  }
}
