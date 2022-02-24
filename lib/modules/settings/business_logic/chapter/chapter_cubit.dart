import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_widget_flutter/data_source/data_source.dart';
import 'package:quran_widget_flutter/model/chapter.dart';

part 'chapter_state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  ChapterCubit() : super(ChapterInitial());

  fetchChaptersList() {
    try {
      DataSource.instance.fetchChaptersList().then((value) async {
        if (value!.isNotEmpty) {
          emit(ChapterFetched(value));
        } else {
          emit(const ChapterError('Not Found Data'));
        }
      });
    } catch (e) {
      emit(ChapterError(e.toString()));
    }
  }
}
