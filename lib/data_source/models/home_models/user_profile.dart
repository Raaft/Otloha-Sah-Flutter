class UserProfile {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? bio;
  String? phone;
  String? level;
  bool? isATeacher;
  int? narrationId;
  String? image;
  String? gender;
  bool? isFavorite;
  String? teacherType;
  bool? isCertified;
  int? favoriteTeacher;
  bool? canReplyOnEveryVerseInRecitation;
  int? rate;

  UserProfile(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.bio,
      this.phone,
      this.level,
      this.isATeacher,
      this.narrationId,
      this.image,
      this.gender,
      this.isFavorite,
      this.teacherType,
      this.isCertified,
      this.favoriteTeacher,
      this.canReplyOnEveryVerseInRecitation,
      this.rate});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    bio = json['bio'];
    phone = json['phone'];
    level = json['level'];
    isATeacher = json['is_a_teacher'];
    narrationId = json['narration_id'];
    image = json['image'];
    gender = json['gender'];
    isFavorite = json['is_favorite'];
    teacherType = json['teacher_type'];
    isCertified = json['is_certified'];
    favoriteTeacher = json['favorite_teacher'];
    canReplyOnEveryVerseInRecitation =
        json['can_reply_on_every_verse_in_recitation'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['bio'] = bio;
    data['phone'] = phone;
    data['level'] = level;
    data['is_a_teacher'] = isATeacher;
    data['narration_id'] = narrationId;
    data['image'] = image;
    data['gender'] = gender;
    data['is_favorite'] = isFavorite;
    data['teacher_type'] = teacherType;
    data['is_certified'] = isCertified;
    data['favorite_teacher'] = favoriteTeacher;
    data['can_reply_on_every_verse_in_recitation'] =
        canReplyOnEveryVerseInRecitation;
    data['rate'] = rate;
    return data;
  }
}
