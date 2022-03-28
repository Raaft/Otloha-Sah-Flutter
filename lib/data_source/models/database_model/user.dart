import 'dart:convert';

class User {
  int uid;
  String name;
  String uImage;
  String phone;
  String email;
  User({
    required this.uid,
    required this.name,
    required this.uImage,
    required this.phone,
    required this.email,
  });

  User copyWith({
    int? uid,
    String? name,
    String? uImage,
    String? phone,
    String? email,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      uImage: uImage ?? this.uImage,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'uImage': uImage,
      'phone': phone,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid']?.toInt() ?? 0,
      name: map['name'] ?? '',
      uImage: map['uImage'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, uImage: $uImage, phone: $phone, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.uid == uid &&
        other.name == name &&
        other.uImage == uImage &&
        other.phone == phone &&
        other.email == email;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        uImage.hashCode ^
        phone.hashCode ^
        email.hashCode;
  }
}
