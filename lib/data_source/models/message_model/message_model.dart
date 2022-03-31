import 'dart:convert';

import 'relpay.dart';




MessageModel resultsFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));
String resultsToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    this.id,
    this.addressee,
    this.addresser,
    this.isRead,
    this.isSent,
    this.recitation,
    this.replies,
  });

  MessageModel.fromJson(dynamic json) {
    id = json['id'];
    addressee = json['addressee'] != null
        ? Addressee.fromJson(json['addressee'])
        : null;
    addresser = json['addresser'] != null
        ? Addresser.fromJson(json['addresser'])
        : null;
    isRead = json['is_read'];
    isSent = json['is_sent'];
    recitation = json['recitation'] != null
        ? Recitation.fromJson(json['recitation'])
        : null;
    // if (json['replies'] != null) {
    //   replies = [];
    //   json['replies'].forEach((v) {
    //     replies?.add(Reply.fromJson(v));
    //   });
    // }
  }
  int? id;
  Addressee? addressee;
  Addresser? addresser;
  bool? isRead;
  bool? isSent;
  Recitation? recitation;
  List<Reply>? replies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (addressee != null) {
      map['addressee'] = addressee?.toJson();
    }
    if (addresser != null) {
      map['addresser'] = addresser?.toJson();
    }
    map['is_read'] = isRead;
    map['is_sent'] = isSent;
    if (recitation != null) {
      map['recitation'] = recitation?.toJson();
    }
    map['replies'] = replies;
    return map;
  }
}

/// id : 201
/// record : "/media/get_upload_record/File_1647791923935_4vUMNU2.wav"
/// wave : ""
/// narration_id : "1"
/// verse_ids : "[4,5]"
/// owner : {"id":41,"username":"Sohype1","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":0,"image":"/media/default/images/profile.png"}
/// chapter_id : 0
/// finished_at : "2022-03-20T15:59:07.245439Z"
/// name : "مالك يوم الدين"

Recitation recitationFromJson(String str) =>
    Recitation.fromJson(json.decode(str));
String recitationToJson(Recitation data) => json.encode(data.toJson());

class Recitation {
  Recitation({
    this.id,
    this.record,
    this.wave,
    this.narrationId,
    this.verseIds,
    this.owner,
    this.chapterId,
    this.finishedAt,
    this.name,
  });

  Recitation.fromJson(dynamic json) {
    id = json['id'];
    record = json['record'];
    wave = json['wave'];
    narrationId = int.parse(json['narration_id'] ?? '0');
    verseIds = List<int>.from(jsonDecode(json['verse_ids']));
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    chapterId = json['chapter_id'];
    finishedAt = json['finished_at'];
    name = json['name'];
  }
  int? id;
  String? record;
  String? wave;
  int? narrationId;
  String? narrationName;
  String? chapterName;
  List<int>? verseIds;
  Owner? owner;
  int? chapterId;
  String? finishedAt;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['record'] = record;
    map['wave'] = wave;
    map['narration_id'] = jsonEncode(narrationId);
    map['verse_ids'] = verseIds;
    if (owner != null) {
      map['owner'] = owner?.toJson();
    }
    map['chapter_id'] = chapterId;
    map['finished_at'] = finishedAt;
    map['name'] = name;
    return map;
  }
}

/// id : 41
/// username : "Sohype1"
/// first_name : ""
/// last_name : ""
/// level : "Beginner"
/// is_a_teacher : false
/// narration_id : 0
/// image : "/media/default/images/profile.png"

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
    narrationId = int.parse(json['narration_id'] ?? '0');
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

/// id : 41
/// username : "Sohype1"
/// first_name : ""
/// last_name : ""
/// level : "Beginner"
/// is_a_teacher : false
/// narration_id : 0
/// image : "/media/default/images/profile.png"

Addresser addresserFromJson(String str) => Addresser.fromJson(json.decode(str));
String addresserToJson(Addresser data) => json.encode(data.toJson());

class Addresser {
  Addresser({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.level,
    this.isATeacher,
    this.narrationId,
    this.image,
  });

  Addresser.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    level = json['level'];
    isATeacher = json['is_a_teacher'];
    narrationId = int.parse(json['narration_id'] ?? '0');
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

/// id : 3
/// first_name : "Andrew"
/// last_name : "Payne"
/// level : "Beginner"
/// is_a_teacher : true
/// narration_id : 0
/// image : "/media/users/2022/20/03/-example_4hN1Zon.jpg"
/// teacher_type : "Volunteer"

Addressee addresseeFromJson(String str) => Addressee.fromJson(json.decode(str));
String addresseeToJson(Addressee data) => json.encode(data.toJson());

class Addressee {
  Addressee({
    this.id,
    this.firstName,
    this.lastName,
    this.level,
    this.isATeacher,
    this.narrationId,
    this.image,
    this.teacherType,
  });

  Addressee.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    level = json['level'];
    isATeacher = json['is_a_teacher'];
    narrationId = int.parse(json['narration_id'] ?? '0');
    image = json['image'];
    teacherType = json['teacher_type'];
  }
  int? id;
  String? firstName;
  String? lastName;
  String? level;
  bool? isATeacher;
  int? narrationId;
  String? image;
  String? teacherType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['level'] = level;
    map['is_a_teacher'] = isATeacher;
    map['narration_id'] = narrationId;
    map['image'] = image;
    map['teacher_type'] = teacherType;
    return map;
  }
}
