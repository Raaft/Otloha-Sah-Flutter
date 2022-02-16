import 'dart:convert';

class Book {
  int? id;
  String? name;
  int? narrationId;
  Book({
    this.id,
    this.name,
    this.narrationId,
  });

  Book copyWith({
    int? id,
    String? name,
    int? narrationId,
  }) {
    return Book(
      id: id ?? this.id,
      name: name ?? this.name,
      narrationId: narrationId ?? this.narrationId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'narrationId': narrationId,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id']?.toInt(),
      name: map['name'],
      narrationId: map['narrationId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  @override
  String toString() => 'Book(id: $id, name: $name, narrationId: $narrationId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Book &&
        other.id == id &&
        other.name == name &&
        other.narrationId == narrationId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ narrationId.hashCode;
}
