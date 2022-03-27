/// username : ["لا يمكن لهذا الحقل ان يكون فارغاً."]
/// email : ["لا يمكن لهذا الحقل ان يكون فارغاً."]
/// password1 : ["لا يمكن لهذا الحقل ان يكون فارغاً."]
/// password2 : ["لا يمكن لهذا الحقل ان يكون فارغاً."]
/// phone : ["لا يمكن لهذا الحقل ان يكون فارغاً."]
/// gender : ["\"\" ليست واحدة من الخيارات الصالحة."]
/// birthdate : ["صيغة التاريخ غير صحيحة. عليك أن تستخدم واحدة من هذه الصيغ التالية: YYYY-MM-DD."]

// ignore_for_file: file_names

class SignUpErrorModel {
  SignUpErrorModel({
      this.username, 
      this.email, 
      this.password1, 
      this.password2, 
      this.phone, 
      this.gender, 
      this.birthdate,});

  SignUpErrorModel.fromJson(dynamic json) {
    username = json['username'] != null ? json['username'].cast<String>() : [];
    email = json['email'] != null ? json['email'].cast<String>() : [];
    password1 = json['password1'] != null ? json['password1'].cast<String>() : [];
    password2 = json['password2'] != null ? json['password2'].cast<String>() : [];
    phone = json['phone'] != null ? json['phone'].cast<String>() : [];
    gender = json['gender'] != null ? json['gender'].cast<String>() : [];
    birthdate = json['birthdate'] != null ? json['birthdate'].cast<String>() : [];
  }
  List<String>? username;
  List<String>? email;
  List<String>? password1;
  List<String>? password2;
  List<String>? phone;
  List<String>? gender;
  List<String>? birthdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['email'] = email;
    map['password1'] = password1;
    map['password2'] = password2;
    map['phone'] = phone;
    map['gender'] = gender;
    map['birthdate'] = birthdate;
    return map;
  }

}