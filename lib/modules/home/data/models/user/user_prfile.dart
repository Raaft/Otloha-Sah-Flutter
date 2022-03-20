import 'dart:convert';

/// id : 42
/// username : "Sohype1"
/// first_name : ""
/// last_name : ""
/// bio : null
/// phone : "155"
/// level : "Beginner"
/// is_a_teacher : false
/// narration_id : null
/// image : "/media/default/images/profile.png"
/// gender : "male"

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));
String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.id,
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
  });

  UserProfile.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    bio = json['bio'];
    phone = json['phone'];
    level = json['level'];
    isATeacher = json['is_a_teacher'];
    narrationId = json['narration_id'];
    narrationId = json['favorite_teacher'];
    image = json['image'];
    gender = json['gender'];
  }
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? bio;
  String? phone;
  String? level;
  bool? isATeacher;
  int? narrationId;
  int? favoriteTeacher;
  String? image;
  String? gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['bio'] = bio;
    map['phone'] = phone;
    map['level'] = level;
    map['is_a_teacher'] = isATeacher;
    map['narration_id'] = narrationId;
    map['favorite_teacher'] = favoriteTeacher;
    map['image'] = image;
    map['gender'] = gender;
    return map;
  }
}
