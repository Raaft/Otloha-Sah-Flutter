class GeneralResponse {
  GeneralResponse({
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

  GeneralResponse.fromJson(dynamic json) {
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
  String? record;
  String? wave;
  String? narrationId;
  String? verseIds;
  Owner? owner;
  List<String>? comments;
  List<String>? likes;
  int? chapterId;
  String? finishedAt;
  String? name;
  List<String>? remarkable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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

/// id : 1
/// first_name : "Whitney"
/// last_name : "Scott"
/// level : "Beginner"
/// is_a_teacher : true
/// narration_id : 0
/// teacher_type : "Volunteer"
/// image : "/media/users/2022/16/03/-example_DtxdEZg.jpg"
/// rate : 4.0

class Owner {
  Owner({
    this.id,
    this.firstName,
    this.lastName,
    this.level,
    this.isATeacher,
    this.narrationId,
    this.teacherType,
    this.image,
    this.rate,
    this.username,
  });

  Owner.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    level = json['level'];
    isCertified = json['is_certified'];
    isATeacher = json['is_a_teacher'];
    narrationId = json['narration_id'];
    teacherType = json['teacher_type'];
    image = json['image'];
    rate = json['rate'];
  }
  int? id;
  String? firstName;
  String? username;
  String? lastName;
  String? level;
  bool? isATeacher;
  bool? isCertified;
  int? narrationId;
  String? teacherType;
  String? image;
  double? rate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['level'] = level;
    map['is_certified'] = isCertified;
    map['username'] = username;
    map['is_a_teacher'] = isATeacher;
    map['narration_id'] = narrationId;
    map['teacher_type'] = teacherType;
    map['image'] = image;
    map['rate'] = rate;
    return map;
  }
}
