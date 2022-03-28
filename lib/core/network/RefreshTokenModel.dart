/// access : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjQ3NTUxOTIxLCJpYXQiOjE2NDc1NDM3NzQsImp0aSI6IjM2Y2E2N2U5NWIwNjRkNzliZTM3NTMzMmRhNTFhZWUyIiwidXNlcl9pZCI6NDZ9.A8Syo2pGG2r8R3jjcQfsQzWKneX86h2DwPiY_Df6vQo"
/// access_token_expiration : "2022-03-17T21:18:41.754675Z"

// ignore_for_file: file_names

class RefreshTokenModel {
  RefreshTokenModel({
      this.access, 
      this.accessTokenExpiration,});

  RefreshTokenModel.fromJson(dynamic json) {
    access = json['access'];
    accessTokenExpiration = json['access_token_expiration'];
  }
  String? access;
  String? accessTokenExpiration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access'] = access;
    map['access_token_expiration'] = accessTokenExpiration;
    return map;
  }

}