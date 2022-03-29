// import 'package:drift/drift.dart';

// class VerseLiked extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get idFromVerse => integer()();
//   IntColumn get idToVerse => integer()();
//   IntColumn get idPage => integer()();
//   IntColumn get pageNumber => integer()();
//   TextColumn get textFristVerse => text().withLength(min: 0, max: 255)();
// }

import 'dart:convert';

class VerseLiked {
  int? id;
  int? idFromVerse;
  int? idToVerse;
  int? idPage;
  int? pageNumber;
  String? textFristVerse;
  VerseLiked({
    this.id,
    this.idFromVerse,
    this.idToVerse,
    this.idPage,
    this.pageNumber,
    this.textFristVerse,
  });

  VerseLiked copyWith({
    int? id,
    int? idFromVerse,
    int? idToVerse,
    int? idPage,
    int? pageNumber,
    String? textFristVerse,
  }) {
    return VerseLiked(
      id: id ?? this.id,
      idFromVerse: idFromVerse ?? this.idFromVerse,
      idToVerse: idToVerse ?? this.idToVerse,
      idPage: idPage ?? this.idPage,
      pageNumber: pageNumber ?? this.pageNumber,
      textFristVerse: textFristVerse ?? this.textFristVerse,
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
    };
  }

  factory VerseLiked.fromMap(Map<String, dynamic> map) {
    return VerseLiked(
      id: map['id']?.toInt(),
      idFromVerse: map['idFromVerse']?.toInt(),
      idToVerse: map['idToVerse']?.toInt(),
      idPage: map['idPage']?.toInt(),
      pageNumber: map['pageNumber']?.toInt(),
      textFristVerse: map['textFristVerse'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VerseLiked.fromJson(String source) =>
      VerseLiked.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VerseLiked(id: $id, idFromVerse: $idFromVerse, idToVerse: $idToVerse, idPage: $idPage, pageNumber: $pageNumber, textFristVerse: $textFristVerse)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VerseLiked &&
        other.id == id &&
        other.idFromVerse == idFromVerse &&
        other.idToVerse == idToVerse &&
        other.idPage == idPage &&
        other.pageNumber == pageNumber &&
        other.textFristVerse == textFristVerse;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idFromVerse.hashCode ^
        idToVerse.hashCode ^
        idPage.hashCode ^
        pageNumber.hashCode ^
        textFristVerse.hashCode;
  }
}
