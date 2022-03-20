import 'dart:convert';

/// addresser : 1
/// addressee : 1
/// accepted_at : ""
/// is_read : true
/// is_sent : true
/// recitation : 1

// ignore_for_file: file_names

class MessageModel {
  MessageModel({
    this.id,
    this.record,
    this.wave,
    this.narrationId,
    this.verseIds,
    this.owner,
    this.comments,
    this.likes,
    this.chapterId,
    this.finishedAt,
    this.name,
    this.remarkable,
  });

  MessageModel.fromJson(dynamic json) {
    id = json['id'];
    record = json['record'];
    wave = json['wave'];
    narrationId = json['narration_id'];
    verseIds = json['verse_ids'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    comments = json['comments'] != null ? json['comments'].cast<String>() : [];
    likes = json['likes'] != null ? json['likes'].cast<String>() : [];
    chapterId = json['chapter_id'];
    finishedAt = json['finished_at'];
    name = json['name'];
    remarkable =
        json['remarkable'] != null ? json['remarkable'].cast<String>() : [];
  }

  int? id;
  String? record;
  dynamic wave;
  int? narrationId;
  String? narrationName;
  String? verseIds;
  Owner? owner;
  List<String>? comments;
  List<String>? likes;
  int? chapterId;
  String? chapterName;
  String? finishedAt;
  String? name;
  List<String>? remarkable;
  bool? isRead;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['record'] = record;
    map['wave'] = wave;
    map['narration_id'] = narrationId;
    map['verse_ids'] = verseIds;
    if (owner != null) {
      map['owner'] = owner?.toJson();
    }
    map['comments'] = comments;
    map['likes'] = likes;
    map['chapter_id'] = chapterId;
    map['finished_at'] = finishedAt;
    map['name'] = name;
    map['remarkable'] = remarkable;
    return map;
  }
}

Owner ownerFromJson(String str) => Owner.fromJson(json.decode(str));
String ownerToJson(Owner data) => json.encode(data.toJson());

class Owner {
  Owner({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.level,
    this.isATeacher,
    this.narrationId,
    this.image,
  });

  Owner.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    level = json['level'];
    isATeacher = json['is_a_teacher'];
    narrationId = json['narration_id'];
    image = json['image'];
  }
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? level;
  bool? isATeacher;
  int? narrationId;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['level'] = level;
    map['is_a_teacher'] = isATeacher;
    map['narration_id'] = narrationId;
    map['image'] = image;
    return map;
  }
}
