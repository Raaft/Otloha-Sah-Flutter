import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_widget_flutter/model/book.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookInitial());

  fetchBooksList() {

  }
}
