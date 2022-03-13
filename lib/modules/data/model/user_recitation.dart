import 'dart:convert';

import 'package:collection/collection.dart';

class UserRecitation {
  int? id;
  int? narrationId; // narration_id
  String? record; // record
  List<int>? versesID; // vseres_ids
  String? name; //name
  bool? uploaded;
  UserRecitation({
    this.id,
    this.narrationId,
    this.record,
    this.versesID,
    this.name,
    this.uploaded,
  });

  UserRecitation copyWith({
    int? id,
    int? narrationId,
    String? record,
    List<int>? versesID,
    String? name,
    bool? uploaded,
  }) {
    return UserRecitation(
      id: id ?? this.id,
      narrationId: narrationId ?? this.narrationId,
      record: record ?? this.record,
      versesID: versesID ?? this.versesID,
      name: name ?? this.name,
      uploaded: uploaded ?? this.uploaded,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'narrationId': narrationId,
      'record': record,
      'versesID': versesID.toString(),
      'name': name,
      'uploaded': uploaded,
    };
  }

  factory UserRecitation.fromMap(Map<String, dynamic> map) {
    return UserRecitation(
      id: map['id']?.toInt(),
      narrationId: map['narrationId']?.toInt(),
      record: map['record'],
      versesID: List<int>.from(map['versesID']),
      name: map['name'],
      uploaded: map['uploaded'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRecitation.fromJson(String source) =>
      UserRecitation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserRecitation(id: $id, narrationId: $narrationId, record: $record, versesID: $versesID, name: $name, uploaded: $uploaded)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is UserRecitation &&
        other.id == id &&
        other.narrationId == narrationId &&
        other.record == record &&
        listEquals(other.versesID, versesID) &&
        other.name == name &&
        other.uploaded == uploaded;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        narrationId.hashCode ^
        record.hashCode ^
        versesID.hashCode ^
        name.hashCode ^
        uploaded.hashCode;
  }
}
