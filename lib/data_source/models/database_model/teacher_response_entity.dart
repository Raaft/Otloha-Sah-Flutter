import 'dart:convert';

class TeacherResponse {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? phone;
  String? bio;
  String? level;
  bool? isTeacher;
  int? narrationId;
  String? narrationName;
  String? gender;
  String? image;
  String? teacherType;
  bool? isCertified;
  bool? canReplyOnEveryVerseInRecitation;
  bool? isFavorite;
  double? rate;

  TeacherResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.phone,
    this.bio,
    this.level,
    this.isTeacher,
    this.narrationId,
    this.gender,
    this.image,
    this.teacherType,
    this.isCertified,
    this.canReplyOnEveryVerseInRecitation,
    this.isFavorite,
    this.rate,
  });

  TeacherResponse copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? username,
    String? phone,
    String? bio,
    String? level,
    bool? isTeacher,
    int? narrationId,
    String? gender,
    String? image,
    String? teacherType,
    bool? isCertified,
    bool? canReplyOnEveryVerseInRecitation,
    bool? isFavorite,
    double? rate,
  }) {
    return TeacherResponse(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      level: level ?? this.level,
      isTeacher: isTeacher ?? this.isTeacher,
      narrationId: narrationId ?? this.narrationId,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      teacherType: teacherType ?? this.teacherType,
      isCertified: isCertified ?? this.isCertified,
      canReplyOnEveryVerseInRecitation: canReplyOnEveryVerseInRecitation ??
          this.canReplyOnEveryVerseInRecitation,
      isFavorite: isFavorite ?? this.isFavorite,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'phone': phone,
      'bio': bio,
      'level': level,
      'is_a_teacher': isTeacher,
      'narration_id': narrationId,
      'gender': gender,
      'image': image,
      'teacher_type': teacherType,
      'is_certified': isCertified,
      'can_reply_on_every_verse_in_recitation':
          canReplyOnEveryVerseInRecitation,
      'is_favorite': isFavorite,
      'rate': rate,
    };
  }

/*
"id": 21,
            "username": "Lonnie.Hernandez.632",
            "first_name": "Lonnie",
            "last_name": "Hernandez",
            "bio": null,
            "phone": "3215616_20",
            "level": "Beginner",
            "is_a_teacher": false,
            "narration_id": null,
            "image": "/media/users/2022/17/03/-example_4lF8Ek1.jpg",
            "gender": "female" 
            
             {
            "id": 1,
            "username": "Paige.Richard.579",
            "first_name": "Paige",
            "last_name": "Richard",
            "bio": null,
            "phone": "3215616_0",
            "level": "Beginner",
            "is_a_teacher": true,
            "narration_id": null,
            "image": "/media/users/2022/17/03/-example_LJc7l2j.jpg",
            "gender": "female",
            "is_favorite": false,
            "teacher_type": "Volunteer",
            "is_certified": true,
            "can_reply_on_every_verse_in_recitation": true,
            "rate": 4.0
        },*/

  /*
  
  Results.fromJson(dynamic json) {
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
    canReplyOnEveryVerseInRecitation = json['can_reply_on_every_verse_in_recitation'];
    rate = json['rate'];
  }
   */

  factory TeacherResponse.fromJson(Map<String, dynamic> map) {
    return TeacherResponse(
      id: map['id']?.toInt(),
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      username: map['username'],
      phone: map['phone'],
      bio: map['bio'],
      level: map['level'],
      isTeacher: map['is_a_teacher'],
      narrationId: int.parse(map['narration_id'] ?? '0'),
      gender: map['gender'],
      image: map['image'],
      teacherType: map['teacher_type'],
      isCertified: map['is_certified'],
      canReplyOnEveryVerseInRecitation:
          map['can_reply_on_every_verse_in_recitation'],
      isFavorite: map['is_favorite'],
      rate: map['rate']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  // factory Results.fromJson(source) => Results.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Results(id: $id, firstName: $firstName, lastName: $lastName, email: $email, username: $username, phone: $phone, bio: $bio, level: $level, isTeacher: $isTeacher, narrationId: $narrationId, gender: $gender, image: $image, teacherType: $teacherType, isCertfited: $isCertified, canReplyOnEveryVerseInRecitation: $canReplyOnEveryVerseInRecitation, isFavorite: $isFavorite, rate: $rate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeacherResponse &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.username == username &&
        other.phone == phone &&
        other.bio == bio &&
        other.level == level &&
        other.isTeacher == isTeacher &&
        other.narrationId == narrationId &&
        other.gender == gender &&
        other.image == image &&
        other.teacherType == teacherType &&
        other.isCertified == isCertified &&
        other.canReplyOnEveryVerseInRecitation ==
            canReplyOnEveryVerseInRecitation &&
        other.isFavorite == isFavorite &&
        other.rate == rate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        username.hashCode ^
        phone.hashCode ^
        bio.hashCode ^
        level.hashCode ^
        isTeacher.hashCode ^
        narrationId.hashCode ^
        gender.hashCode ^
        image.hashCode ^
        teacherType.hashCode ^
        isCertified.hashCode ^
        canReplyOnEveryVerseInRecitation.hashCode ^
        isFavorite.hashCode ^
        rate.hashCode;
  }
}
