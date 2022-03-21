import 'dart:convert';

import 'package:flutter_base/modules/messages/data/models/relpay.dart';

/// count : 7
/// next : null
/// previous : null
/// results : [{"id":10,"addressee":{"id":3,"first_name":"Alexis","last_name":"Williams","level":"Beginner","is_a_teacher":true,"narration_id":null,"image":"/media/users/2022/20/03/-example_NnSyxMx.jpg","teacher_type":"Paid"},"addresser":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"is_read":false,"is_sent":true,"recitation":{"id":202,"record":"/media/get_upload_record/File_1647817935652_RQv4GsW.wav","wave":null,"narration_id":"1","verse_ids":"[1,2,3,4,5,6]","owner":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"chapter_id":null,"finished_at":"2022-03-20T23:12:42.351753Z","name":"بسم الله الرحمن الرحيم"},"replies":[],"is_remarkable":false,"is_accepted":false},{"id":9,"addressee":{"id":1,"first_name":"Victoria","last_name":"Phillips","level":"Beginner","is_a_teacher":true,"narration_id":null,"image":"/media/users/2022/20/03/-example_L0qjaT8.jpg","teacher_type":"Paid"},"addresser":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"is_read":false,"is_sent":true,"recitation":{"id":202,"record":"/media/get_upload_record/File_1647817935652_RQv4GsW.wav","wave":null,"narration_id":"1","verse_ids":"[1,2,3,4,5,6]","owner":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"chapter_id":null,"finished_at":"2022-03-20T23:12:42.351753Z","name":"بسم الله الرحمن الرحيم"},"replies":[],"is_remarkable":false,"is_accepted":false},{"id":8,"addressee":{"id":2,"first_name":"Brenda","last_name":"Hoffman","level":"Beginner","is_a_teacher":true,"narration_id":null,"image":"/media/users/2022/20/03/-example_AwdtprD.jpg","teacher_type":"Paid"},"addresser":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"is_read":false,"is_sent":true,"recitation":{"id":202,"record":"/media/get_upload_record/File_1647817935652_RQv4GsW.wav","wave":null,"narration_id":"1","verse_ids":"[1,2,3,4,5,6]","owner":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"chapter_id":null,"finished_at":"2022-03-20T23:12:42.351753Z","name":"بسم الله الرحمن الرحيم"},"replies":[],"is_remarkable":false,"is_accepted":false},{"id":7,"addressee":{"id":1,"first_name":"Victoria","last_name":"Phillips","level":"Beginner","is_a_teacher":true,"narration_id":null,"image":"/media/users/2022/20/03/-example_L0qjaT8.jpg","teacher_type":"Paid"},"addresser":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"is_read":false,"is_sent":true,"recitation":{"id":202,"record":"/media/get_upload_record/File_1647817935652_RQv4GsW.wav","wave":null,"narration_id":"1","verse_ids":"[1,2,3,4,5,6]","owner":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"chapter_id":null,"finished_at":"2022-03-20T23:12:42.351753Z","name":"بسم الله الرحمن الرحيم"},"replies":[],"is_remarkable":false,"is_accepted":false},{"id":6,"addressee":{"id":3,"first_name":"Alexis","last_name":"Williams","level":"Beginner","is_a_teacher":true,"narration_id":null,"image":"/media/users/2022/20/03/-example_NnSyxMx.jpg","teacher_type":"Paid"},"addresser":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"is_read":false,"is_sent":true,"recitation":{"id":202,"record":"/media/get_upload_record/File_1647817935652_RQv4GsW.wav","wave":null,"narration_id":"1","verse_ids":"[1,2,3,4,5,6]","owner":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"chapter_id":null,"finished_at":"2022-03-20T23:12:42.351753Z","name":"بسم الله الرحمن الرحيم"},"replies":[],"is_remarkable":false,"is_accepted":false},{"id":5,"addressee":{"id":2,"first_name":"Brenda","last_name":"Hoffman","level":"Beginner","is_a_teacher":true,"narration_id":null,"image":"/media/users/2022/20/03/-example_AwdtprD.jpg","teacher_type":"Paid"},"addresser":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"is_read":false,"is_sent":true,"recitation":{"id":202,"record":"/media/get_upload_record/File_1647817935652_RQv4GsW.wav","wave":null,"narration_id":"1","verse_ids":"[1,2,3,4,5,6]","owner":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"chapter_id":null,"finished_at":"2022-03-20T23:12:42.351753Z","name":"بسم الله الرحمن الرحيم"},"replies":[],"is_remarkable":false,"is_accepted":false},{"id":4,"addressee":{"id":1,"first_name":"Victoria","last_name":"Phillips","level":"Beginner","is_a_teacher":true,"narration_id":null,"image":"/media/users/2022/20/03/-example_L0qjaT8.jpg","teacher_type":"Paid"},"addresser":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"is_read":false,"is_sent":true,"recitation":{"id":202,"record":"/media/get_upload_record/File_1647817935652_RQv4GsW.wav","wave":null,"narration_id":"1","verse_ids":"[1,2,3,4,5,6]","owner":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"chapter_id":null,"finished_at":"2022-03-20T23:12:42.351753Z","name":"بسم الله الرحمن الرحيم"},"replies":[],"is_remarkable":false,"is_accepted":false}]

MessageDelails testttFromJson(String str) =>
    MessageDelails.fromJson(json.decode(str));
String testttToJson(MessageDelails data) => json.encode(data.toJson());

class MessageDelails {
  MessageDelails({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  MessageDelails.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }
  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 10
/// addressee : {"id":3,"first_name":"Alexis","last_name":"Williams","level":"Beginner","is_a_teacher":true,"narration_id":null,"image":"/media/users/2022/20/03/-example_NnSyxMx.jpg","teacher_type":"Paid"}
/// addresser : {"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"}
/// is_read : false
/// is_sent : true
/// recitation : {"id":202,"record":"/media/get_upload_record/File_1647817935652_RQv4GsW.wav","wave":null,"narration_id":"1","verse_ids":"[1,2,3,4,5,6]","owner":{"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"chapter_id":null,"finished_at":"2022-03-20T23:12:42.351753Z","name":"بسم الله الرحمن الرحيم"}
/// replies : []
/// is_remarkable : false
/// is_accepted : false

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));
String resultsToJson(Results data) => json.encode(data.toJson());

class Results {
  Results({
    this.id,
    this.addressee,
    this.addresser,
    this.isRead,
    this.isSent,
    this.recitation,
    this.replies,
    this.isRemarkable,
    this.isAccepted,
  });

  Results.fromJson(dynamic json) {
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
    if (json['replies'] != null) {
      replies = [];
      json['replies'].forEach((v) {
        replies?.add(Reply.fromJson(v));
      });
    }
    isRemarkable = json['is_remarkable'];
    isAccepted = json['is_accepted'];
  }
  int? id;
  Addressee? addressee;
  Addresser? addresser;
  bool? isRead;
  bool? isSent;
  Recitation? recitation;
  List<Reply>? replies;
  bool? isRemarkable;
  bool? isAccepted;

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
    if (replies != null) {
      map['replies'] = replies?.map((v) => v.toJson()).toList();
    }
    map['is_remarkable'] = isRemarkable;
    map['is_accepted'] = isAccepted;
    return map;
  }
}

/// id : 202
/// record : "/media/get_upload_record/File_1647817935652_RQv4GsW.wav"
/// wave : null
/// narration_id : "1"
/// verse_ids : "[1,2,3,4,5,6]"
/// owner : {"id":42,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"}
/// chapter_id : null
/// finished_at : "2022-03-20T23:12:42.351753Z"
/// name : "بسم الله الرحمن الرحيم"

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
    narrationId = json['narration_id'];
    verseIds = List<int>.from(jsonDecode(json['verse_ids']));
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    chapterId = json['chapter_id'];
    finishedAt = json['finished_at'];
    name = json['name'];
  }
  int? id;
  String? record;
  dynamic wave;
  String? narrationId;
  List<int>? verseIds;
  Owner? owner;
  dynamic chapterId;
  String? finishedAt;
  String? name;

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
    map['chapter_id'] = chapterId;
    map['finished_at'] = finishedAt;
    map['name'] = name;
    return map;
  }
}

/// id : 42
/// username : "Shadyd"
/// first_name : ""
/// last_name : ""
/// level : "Beginner"
/// is_a_teacher : false
/// narration_id : null
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
    narrationId = json['narration_id'];
    image = json['image'];
  }
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? level;
  bool? isATeacher;
  dynamic narrationId;
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

/// id : 42
/// username : "Shadyd"
/// first_name : ""
/// last_name : ""
/// level : "Beginner"
/// is_a_teacher : false
/// narration_id : null
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
    narrationId = json['narration_id'];
    image = json['image'];
  }
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? level;
  bool? isATeacher;
  dynamic narrationId;
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
/// first_name : "Alexis"
/// last_name : "Williams"
/// level : "Beginner"
/// is_a_teacher : true
/// narration_id : null
/// image : "/media/users/2022/20/03/-example_NnSyxMx.jpg"
/// teacher_type : "Paid"

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
    narrationId = json['narration_id'];
    image = json['image'];
    teacherType = json['teacher_type'];
  }
  int? id;
  String? firstName;
  String? lastName;
  String? level;
  bool? isATeacher;
  dynamic narrationId;
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
