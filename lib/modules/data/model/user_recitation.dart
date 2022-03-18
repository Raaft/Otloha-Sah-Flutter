import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserRecitation {
  int? id;
  int? narrationId; // narration_id
  int? userId; // narration_id
  int? chapterId; // narration_id
  String? record; // record
  String? wavePath; // record
  List<int>? versesID; // vseres_ids
  String? name; //name
  bool? uploaded;
  bool? isAccepted;
  bool? isTeacherRecitation;
  bool? showInGeneral;
  DateTime? finishedAt;
  DateTime? archivedAt;

  UserRecitation({
    this.id,
    this.narrationId,
    this.userId,
    this.record,
    this.versesID,
    this.name,
    this.uploaded,
    this.isAccepted,
    this.isTeacherRecitation,
    this.showInGeneral,
    this.finishedAt,
    this.archivedAt,
    this.wavePath,
    this.chapterId,
  });

  UserRecitation copyWith({
    int? id,
    int? narrationId,
    String? record,
    List<int>? versesID,
    String? name,
    bool? uploaded,
    bool? isAccepted,
    bool? isTeacherRecitation,
    bool? showInGeneral,
    DateTime? finishedAt,
    DateTime? archivedAt,
  }) {
    return UserRecitation(
      id: id ?? this.id,
      narrationId: narrationId ?? this.narrationId,
      record: record ?? this.record,
      versesID: versesID ?? this.versesID,
      name: name ?? this.name,
      uploaded: uploaded ?? this.uploaded,
      isAccepted: isAccepted ?? this.isAccepted,
      isTeacherRecitation: isTeacherRecitation ?? this.isTeacherRecitation,
      showInGeneral: showInGeneral ?? this.showInGeneral,
      finishedAt: finishedAt ?? this.finishedAt,
      archivedAt: archivedAt ?? this.archivedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'narration_id': narrationId,
      'user_id': userId,
      'record': record,
      'verse_ids': jsonEncode(versesID),
      'name': name,
      'wavePath': wavePath,
      'chapter_id': chapterId,
      'uploaded': uploaded,
      'is_accepted': isAccepted,
      'is_teacher_recitation': isTeacherRecitation,
      'show_in_general': showInGeneral,
      'finished_at': finishedAt?.millisecondsSinceEpoch,
      'archived_at': archivedAt?.millisecondsSinceEpoch,
    };
  }

  factory UserRecitation.fromMap(Map<String, dynamic> map) {
    print(map['is_teacher_recitation']);
    return UserRecitation(
      id: map['id'],
      narrationId: int.parse(map['narration_id'].toString()),
      record: map['record'],
      userId: map['user_id'],
      versesID: List<int>.from(jsonDecode(map['verse_ids'])),
      name: map['name'],
      wavePath: map['wavePath'],
      uploaded: map['uploaded'],
      chapterId: map['chapter_id'],
      isAccepted: map['is_accepted'],
      isTeacherRecitation: (map['is_teacher_recitation'] ?? false) == 1,
      showInGeneral: (map['show_in_general'] ?? false) == 1,
      finishedAt: map['finished_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['finished_at'])
          : null,
      archivedAt: map['archived_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['archived_at'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserRecitation(id: $id, narrationId: $narrationId, record: $record, versesID: $versesID, name: $name, uploaded: $uploaded, isAccepted: $isAccepted, isTeacherRecitation: $isTeacherRecitation, showInGeneral: $showInGeneral, finishedAt: $finishedAt, archivedAt: $archivedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserRecitation &&
        other.id == id &&
        other.narrationId == narrationId &&
        other.record == record &&
        listEquals(other.versesID, versesID) &&
        other.name == name &&
        other.uploaded == uploaded &&
        other.isAccepted == isAccepted &&
        other.isTeacherRecitation == isTeacherRecitation &&
        other.showInGeneral == showInGeneral &&
        other.finishedAt == finishedAt &&
        other.archivedAt == archivedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        narrationId.hashCode ^
        record.hashCode ^
        versesID.hashCode ^
        name.hashCode ^
        uploaded.hashCode ^
        isAccepted.hashCode ^
        isTeacherRecitation.hashCode ^
        showInGeneral.hashCode ^
        finishedAt.hashCode ^
        archivedAt.hashCode;
  }
}
