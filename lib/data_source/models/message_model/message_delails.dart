import 'dart:convert';

/// id : 4
/// addressee : {"id":2,"first_name":"Colleen","last_name":"Johns","level":"Beginner","is_a_teacher":true,"narration_id":null,"image":"/media/users/2022/20/03/-example_jaSLCYW.jpg","teacher_type":"Volunteer"}
/// addresser : {"id":41,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"}
/// is_read : false
/// is_sent : true
/// recitation : {"id":201,"record":"/media/get_upload_record/booking_Y6dGQtv.png","wave":null,"narration_id":"1","verse_ids":"[1,2,3]","owner":{"id":41,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"chapter_id":null,"finished_at":"2022-03-21T13:10:38.232721Z","name":"الحمد لله رب العالمين"}
/// replies : [{"id":3,"text":null,"record":"/media/messages/4/3d3193b9-9794-4780-9215-ee282128966d-record-booking.png","wave":"/media/messages/4/3d3193b9-9794-4780-9215-ee282128966d-wave-bubble.png","comment":null,"error_type":"","position_from":null,"position_to":null,"owner":{"id":41,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"},"parent":null,"children":[]}]
/// is_remarkable : false
/// is_accepted : false

MessageDelails msgdetailsFromJson(String str) =>
    MessageDelails.fromJson(json.decode(str));
String msgdetailsToJson(MessageDelails data) => json.encode(data.toJson());

class MessageDelails {
  MessageDelails({
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

  MessageDelails.fromJson(dynamic json) {
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
        replies?.add(Replies.fromJson(v));
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
  List<Replies>? replies;
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

/// id : 3
/// text : null
/// record : "/media/messages/4/3d3193b9-9794-4780-9215-ee282128966d-record-booking.png"
/// wave : "/media/messages/4/3d3193b9-9794-4780-9215-ee282128966d-wave-bubble.png"
/// comment : null
/// error_type : ""
/// position_from : null
/// position_to : null
/// owner : {"id":41,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"}
/// parent : null
/// children : []

Replies repliesFromJson(String str) => Replies.fromJson(json.decode(str));
String repliesToJson(Replies data) => json.encode(data.toJson());

class Replies {
  Replies({
    this.id,
    this.text,
    this.record,
    this.wave,
    this.comment,
    this.errorType,
    this.positionFrom,
    this.positionTo,
    this.owner,
    this.parent,
    this.children,
  });

  Replies.fromJson(dynamic json) {
    id = json['id'];
    text = json['text'];
    record = json['record'];
    wave = json['wave'];
    comment = json['comment'];
    errorType = json['error_type'];
    positionFrom = json['position_from'];
    positionTo = json['position_to'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    parent = json['parent'];
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children?.add(Replies.fromJson(v));
      });
    }
  }
  int? id;
  String? text;
  String? record;
  String? wave;
  String? comment;
  String? errorType;
  int? positionFrom;
  int? positionTo;
  Owner? owner;
  int? parent;
  List<Replies>? children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['text'] = text;
    map['record'] = record;
    map['wave'] = wave;
    map['comment'] = comment;
    map['error_type'] = errorType;
    map['position_from'] = positionFrom;
    map['position_to'] = positionTo;
    if (owner != null) {
      map['owner'] = owner?.toJson();
    }
    map['parent'] = parent;
    if (children != null) {
      map['children'] = children?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 41
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

/// id : 201
/// record : "/media/get_upload_record/booking_Y6dGQtv.png"
/// wave : null
/// narration_id : "1"
/// verse_ids : "[1,2,3]"
/// owner : {"id":41,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":null,"image":"/media/default/images/profile.png"}
/// chapter_id : null
/// finished_at : "2022-03-21T13:10:38.232721Z"
/// name : "الحمد لله رب العالمين"

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

/// id : 41
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

/// id : 2
/// first_name : "Colleen"
/// last_name : "Johns"
/// level : "Beginner"
/// is_a_teacher : true
/// narration_id : null
/// image : "/media/users/2022/20/03/-example_jaSLCYW.jpg"
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
