part of 'book_cubit.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookFetched extends BookState {
  final List<Book> books;
  final int selected;
  const BookFetched(this.books, this.selected);
}

class BookChangeIndex extends BookState {
  final List<Book>? books;
  final int selected;
  const BookChangeIndex(this.books, this.selected);
}

class BookError extends BookState {
  final String error;
  const BookError(this.error);
}
