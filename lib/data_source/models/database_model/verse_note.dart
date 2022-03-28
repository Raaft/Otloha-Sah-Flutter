import 'dart:convert';

class VerseNote {
  int? id;
  int? idFromVerse;
  int? idToVerse;
  int? idPage;
  int? pageNumber;
  String? textFristVerse;
  String? noteText;
  VerseNote({
    this.id,
    this.idFromVerse,
    this.idToVerse,
    this.idPage,
    this.pageNumber,
    this.textFristVerse,
    this.noteText,
  });

  VerseNote copyWith({
    int? id,
    int? idFromVerse,
    int? idToVerse,
    int? idPage,
    int? pageNumber,
    String? textFristVerse,
    String? noteText,
  }) {
    return VerseNote(
      id: id ?? this.id,
      idFromVerse: idFromVerse ?? this.idFromVerse,
      idToVerse: idToVerse ?? this.idToVerse,
      idPage: idPage ?? this.idPage,
      pageNumber: pageNumber ?? this.pageNumber,
      textFristVerse: textFristVerse ?? this.textFristVerse,
      noteText: noteText ?? this.noteText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idFromVerse': idFromVerse,
      'idToVerse': idToVerse,
      'idPage': idPage,
      'pageNumber': pageNumber,
      'textFristVerse': textFristVerse,
      'noteText': noteText,
    };
  }

  factory VerseNote.fromMap(Map<String, dynamic> map) {
    return VerseNote(
      id: map['id']?.toInt(),
      idFromVerse: map['idFromVerse']?.toInt(),
      idToVerse: map['idToVerse']?.toInt(),
      idPage: map['idPage']?.toInt(),
      pageNumber: map['pageNumber']?.toInt(),
      textFristVerse: map['textFristVerse'],
      noteText: map['noteText'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VerseNote.fromJson(String source) =>
      VerseNote.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VerseNote(id: $id, idFromVerse: $idFromVerse, idToVerse: $idToVerse, idPage: $idPage, pageNumber: $pageNumber, textFristVerse: $textFristVerse, noteText: $noteText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VerseNote &&
        other.id == id &&
        other.idFromVerse == idFromVerse &&
        other.idToVerse == idToVerse &&
        other.idPage == idPage &&
        other.pageNumber == pageNumber &&
        other.textFristVerse == textFristVerse &&
        other.noteText == noteText;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idFromVerse.hashCode ^
        idToVerse.hashCode ^
        idPage.hashCode ^
        pageNumber.hashCode ^
        textFristVerse.hashCode ^
        noteText.hashCode;
  }
}
