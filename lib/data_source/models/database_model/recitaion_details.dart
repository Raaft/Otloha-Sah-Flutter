import 'dart:convert';

/// id : 201
/// record : "/media/get_upload_record/booking_Y6dGQtv.png"
/// wave : 0
/// narration_id : 1
/// verse_ids : [1,2,3]
/// owner : {"id":41,"username":"Shadyd","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":0,"image":"/media/default/images/profile.png"}
/// comments : [""]
/// likes : [""]
/// chapter_id : 0
/// finished_at : "2022-03-21T13:10:38.232721Z"
/// name : "الحمد لله رب العالمين"
/// remarkable : [""]
/// show_in_general : false
/// can_create_message : false

RecitationDetails rciFromJson(String str) =>
    RecitationDetails.fromJson(json.decode(str));
String rciToJson(RecitationDetails data) => json.encode(data.toJson());

class RecitationDetails {
  RecitationDetails({
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
    this.showInGeneral,
    this.canCreateMessage,
  });

  RecitationDetails.fromJson(dynamic json) {
    id = json['id'];
    record = json['record'];
    wave = json['wave'];
    narrationId = int.parse(json['narration_id'] ?? '0');
    verseIds = List<int>.from(jsonDecode(json['verse_ids']));
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    comments = json['comments'] != null ? json['comments'].cast<String>() : [];
    likes = json['likes'] != null ? json['likes'].cast<String>() : [];
    chapterId = json['chapter_id'];
    finishedAt = json['finished_at'];
    name = json['name'];
    remarkable =
        json['remarkable'] != null ? json['remarkable'].cast<String>() : [];
    showInGeneral = json['show_in_general'];
    canCreateMessage = json['can_create_message'];
  }
  int? id;
  String? record;
  String? wave;
  int? narrationId;
  String? narrationName;
  List<int>? verseIds;
  Owner? owner;
  List<String>? comments;
  List<String>? likes;
  int? chapterId;
  String? finishedAt;
  String? name;
  List<String>? remarkable;
  bool? showInGeneral;
  bool? canCreateMessage;

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
    map['show_in_general'] = showInGeneral;
    map['can_create_message'] = canCreateMessage;
    return map;
  }
}

/// id : 41
/// username : "Shadyd"
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
