import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/modules/settings/data/models/init_data.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  List<Book>? books;
  int? selected;

  BookCubit() : super(BookInitial());

  changeIndex(int index) {
    selected = index;
    print(selected);
    emit(BookFetched(books, index));
  }

  fetchBooksList({String? qurey}) {
    try {
      int? narrationId = CacheHelper.getData(key: 'NarrationsSelected') as int?;
      DataSource.instance
          .fetchBooksList(qurey: qurey, narrationId: narrationId)
          .then((value) async {
        print(value);

        if (value!.isNotEmpty) {
          int val = (CacheHelper.getData(key: 'BookSelected') as int?) ?? -1;
          for (var element in value) {
            if (element.id == val) {
              val = value.indexOf(element);
              downLoadSettings[0].subTitle = element.name;
              break;
            }
          }

          books = value;
          selected = val;
          emit(BookInitial());
          emit(BookFetched(value, val));
        } else {
          emit(const BookError('Not Found Data'));
        }
      });
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }
}
