// access_token : "jqsDKVl8QRyQL7wfJ2OuRvNQKHHvQU"
/// expires_in : 36000
/// token_type : "Bearer"
/// scope : "read write groups"
/// refresh_token : "cWyC666pAfASsxCbEDPFHv2qIn6B5f"

// ignore_for_file: file_names

class UserModel {
  UserModel({
      this.accessToken, 
      this.expiresIn, 
      this.tokenType, 
      this.scope, 
      this.refreshToken,});

  UserModel.fromJson(dynamic json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    tokenType = json['token_type'];
    scope = json['scope'];
    refreshToken = json['refresh_token'];
  }
  String? accessToken;
  int? expiresIn;
  String? tokenType;
  String? scope;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['expires_in'] = expiresIn;
    map['token_type'] = tokenType;
    map['scope'] = scope;
    map['refresh_token'] = refreshToken;
    return map;
  }

}