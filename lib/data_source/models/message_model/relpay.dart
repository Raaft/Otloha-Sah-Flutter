import 'dart:convert';

Reply replyFromJson(String str) => Reply.fromJson(json.decode(str));
String replyToJson(Reply data) => json.encode(data.toJson());

class Reply {
  Reply({
    this.id,
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

  Reply.fromJson(dynamic json) {
    id = json['id'];
    record = json['record'];
    wave = json['wave'];
    comment = json['comment'];
    errorType = json['error_type'];
    positionFrom = json['position_from'];
    positionTo = json['position_to'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    parent = int.parse(json['parent'] ?? '0');
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children?.add(Reply.fromJson(v));
      });
    }
  }
  int? id;
  String? record;
  String? wave;
  String? comment;
  String? errorType;
  int? positionFrom;
  int? positionTo;
  Owner? owner;
  int? parent;
  List<Reply>? children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
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

/// id : 43
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
