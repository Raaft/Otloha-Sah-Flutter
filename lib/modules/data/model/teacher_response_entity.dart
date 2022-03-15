import 'dart:convert';

import 'package:collection/collection.dart';

class TeacherResponse {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;
  TeacherResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  TeacherResponse copyWith({
    int? count,
    String? next,
    String? previous,
    List<Results>? results,
  }) {
    return TeacherResponse(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results?.map((x) => x.toMap()).toList(),
    };
  }

  factory TeacherResponse.fromMap(Map<String, dynamic> map) {
    return TeacherResponse(
      count: map['count']?.toInt(),
      next: map['next'],
      previous: map['previous'],
      results: map['results'] != null
          ? List<Results>.from(map['results']?.map((x) => Results.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherResponse.fromJson(String source) =>
      TeacherResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TeacherResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is TeacherResponse &&
        other.count == count &&
        other.next == next &&
        other.previous == previous &&
        listEquals(other.results, results);
  }

  @override
  int get hashCode {
    return count.hashCode ^
        next.hashCode ^
        previous.hashCode ^
        results.hashCode;
  }
}

class Results {
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
  bool? isCertfited;
  bool? canReplyOnEveryVerseInRecitation;
  bool? isFavorite;
  double? rate;
  Results({
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
    this.isCertfited,
    this.canReplyOnEveryVerseInRecitation,
    this.isFavorite,
    this.rate,
  });

  Results copyWith({
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
    bool? isCertfited,
    bool? canReplyOnEveryVerseInRecitation,
    bool? isFavorite,
    double? rate,
  }) {
    return Results(
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
      isCertfited: isCertfited ?? this.isCertfited,
      canReplyOnEveryVerseInRecitation: canReplyOnEveryVerseInRecitation ??
          this.canReplyOnEveryVerseInRecitation,
      isFavorite: isFavorite ?? this.isFavorite,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'phone': phone,
      'bio': bio,
      'level': level,
      'isTeacher': isTeacher,
      'narrationId': narrationId,
      'gender': gender,
      'image': image,
      'teacherType': teacherType,
      'isCertfited': isCertfited,
      'canReplyOnEveryVerseInRecitation': canReplyOnEveryVerseInRecitation,
      'isFavorite': isFavorite,
      'rate': rate,
    };
  }

  factory Results.fromMap(Map<String, dynamic> map) {
    return Results(
      id: map['id']?.toInt(),
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      username: map['username'],
      phone: map['phone'],
      bio: map['bio'],
      level: map['level'],
      isTeacher: map['isTeacher'],
      narrationId: map['narrationId']?.toInt(),
      gender: map['gender'],
      image: map['image'],
      teacherType: map['teacherType'],
      isCertfited: map['isCertfited'],
      canReplyOnEveryVerseInRecitation: map['canReplyOnEveryVerseInRecitation'],
      isFavorite: map['isFavorite'],
      rate: map['rate']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Results.fromJson(String source) =>
      Results.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Results(id: $id, firstName: $firstName, lastName: $lastName, email: $email, username: $username, phone: $phone, bio: $bio, level: $level, isTeacher: $isTeacher, narrationId: $narrationId, gender: $gender, image: $image, teacherType: $teacherType, isCertfited: $isCertfited, canReplyOnEveryVerseInRecitation: $canReplyOnEveryVerseInRecitation, isFavorite: $isFavorite, rate: $rate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Results &&
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
        other.isCertfited == isCertfited &&
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
        isCertfited.hashCode ^
        canReplyOnEveryVerseInRecitation.hashCode ^
        isFavorite.hashCode ^
        rate.hashCode;
  }
}
