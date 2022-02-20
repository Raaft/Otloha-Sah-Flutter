import 'dart:convert';

class PageMarked {
  int? id;
  int? idPage;
  int? idBook;
  int? pageNumber;
  String? text;

  PageMarked({
    this.id,
    this.idPage,
    this.idBook,
    this.pageNumber,
    this.text,
  });

  PageMarked copyWith({
    int? id,
    int? idPage,
    int? idBook,
    int? pageNumber,
    String? text,
  }) {
    return PageMarked(
      id: id ?? this.id,
      idPage: idPage ?? this.idPage,
      idBook: idBook ?? this.idBook,
      pageNumber: pageNumber ?? this.pageNumber,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idPage': idPage,
      'idBook': idBook,
      'pageNumber': pageNumber,
      'text': text,
    };
  }

  factory PageMarked.fromMap(Map<String, dynamic> map) {
    return PageMarked(
      id: map['id']?.toInt(),
      idPage: map['idPage']?.toInt(),
      idBook: map['idBook']?.toInt(),
      pageNumber: map['pageNumber']?.toInt(),
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PageMarked.fromJson(String source) =>
      PageMarked.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PageMarked(id: $id, idPage: $idPage, idBook: $idBook, pageNumber: $pageNumber, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PageMarked &&
        other.id == id &&
        other.idPage == idPage &&
        other.idBook == idBook &&
        other.pageNumber == pageNumber &&
        other.text == text;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idPage.hashCode ^
        idBook.hashCode ^
        pageNumber.hashCode ^
        text.hashCode;
  }
}
