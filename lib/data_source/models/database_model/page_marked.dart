import 'dart:convert';

class PageMarked {
  int? id;
  int? idPage;
  int? idBook;
  int? pageNumber;
  String? textVerse;

  PageMarked({
    this.id,
    this.idPage,
    this.idBook,
    this.pageNumber,
    this.textVerse,
  });

  PageMarked copyWith({
    int? id,
    int? idPage,
    int? idBook,
    int? pageNumber,
    String? textVerse,
  }) {
    return PageMarked(
      id: id ?? this.id,
      idPage: idPage ?? this.idPage,
      idBook: idBook ?? this.idBook,
      pageNumber: pageNumber ?? this.pageNumber,
      textVerse: textVerse ?? this.textVerse,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idPage': idPage,
      'idBook': idBook,
      'pageNumber': pageNumber,
      'textVerse': textVerse,
    };
  }

  factory PageMarked.fromMap(Map<String, dynamic> map) {
    return PageMarked(
      id: map['id']?.toInt(),
      idPage: map['idPage']?.toInt(),
      idBook: map['idBook']?.toInt(),
      pageNumber: map['pageNumber']?.toInt(),
      textVerse: map['textVerse'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PageMarked.fromJson(String source) =>
      PageMarked.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PageMarked(id: $id, idPage: $idPage, idBook: $idBook, pageNumber: $pageNumber, textVerse: $textVerse)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PageMarked &&
        other.id == id &&
        other.idPage == idPage &&
        other.idBook == idBook &&
        other.pageNumber == pageNumber &&
        other.textVerse == textVerse;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idPage.hashCode ^
        idBook.hashCode ^
        pageNumber.hashCode ^
        textVerse.hashCode;
  }
}
