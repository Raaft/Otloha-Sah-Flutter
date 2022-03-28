// ignore_for_file: file_names

class UserModel {
  String? accessToken;
  String? refreshToken;
  User? user;

  UserModel({this.accessToken, this.refreshToken, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? pk;
  String? email;
  String? firstName;
  String? lastName;

  User({this.pk, this.email, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pk'] = pk;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
