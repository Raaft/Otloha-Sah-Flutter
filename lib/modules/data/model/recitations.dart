import 'dart:convert';

/// count : 3
/// next : ""
/// previous : ""
/// results : [{"id":203,"record":"http://46.101.113.121/media/get_upload_record/waveform_1yiziut.mp3","wave":"","narration_id":"1","verse_ids":"[1,2,3]","owner":{"id":41,"username":"joe","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":0,"image":"/media/default/images/profile.png"},"comments":[""],"likes":[""],"chapter_id":"","finished_at":"","name":"الحمد لله رب العالمين","remarkable":[""]}]

Recitations recitationFromJson(String str) =>
    Recitations.fromJson(json.decode(str));
String recitationToJson(Recitations data) => json.encode(data.toJson());

class Recitations {
  Recitations({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  Recitations.fromJson(dynamic json) {
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
  String? next;
  String? previous;
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

/// id : 203
/// record : "http://46.101.113.121/media/get_upload_record/waveform_1yiziut.mp3"
/// wave : ""
/// narration_id : "1"
/// verse_ids : "[1,2,3]"
/// owner : {"id":41,"username":"joe","first_name":"","last_name":"","level":"Beginner","is_a_teacher":false,"narration_id":0,"image":"/media/default/images/profile.png"}
/// comments : [""]
/// likes : [""]
/// chapter_id : ""
/// finished_at : ""
/// name : "الحمد لله رب العالمين"
/// remarkable : [""]

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));
String resultsToJson(Results data) => json.encode(data.toJson());

class Results {
  Results({
    this.id,
    this.record,
    this.wave,
    this.narrationId,
    this.versesID,
    this.owner,
    this.comments,
    this.likes,
    this.chapterId,
    this.finishedAt,
    this.name,
    this.remarkable,
  });

  Results.fromJson(dynamic json) {
    id = json['id'];
    record = json['record'];
    showInGeneral = json['show_in_general'];
    wave = json['wave'];
    narrationId = int.parse(json['narration_id'] ?? '0');
    versesID = List<int>.from(jsonDecode(json['verse_ids']));
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    comments = json['comments'] != null ? json['comments'].cast<String>() : [];
    likes = json['likes'] != null ? json['likes'].cast<String>() : [];
    chapterId = int.parse(json['chapter_id'] ?? '0');
    finishedAt = json['finished_at'];
    name = json['name'];
    remarkable =
        json['remarkable'] != null ? json['remarkable'].cast<String>() : [];
  }
  int? id;
  String? record;
  String? wave;
  int? narrationId;
  List<int>? versesID;
  String? chapterName;
  String? narrationName;
  int? verseStart;
  int? verseEnd;
  Owner? owner;
  List<String>? comments;
  List<String>? likes;
  int? chapterId;
  String? finishedAt;
  String? name;
  List<String>? remarkable;
  bool? showInGeneral;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['record'] = record;
    map['wave'] = wave;
    map['narration_id'] = narrationId;
    map['show_in_general'] = showInGeneral;
    map['verse_ids'] = jsonEncode(versesID);
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

/// id : 41
/// username : "joe"
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
