/// non_field_errors : ["تعذر تسجيل الدخول بالبيانات التي ادخلتها."]

class LogInErrorModel {
  LogInErrorModel({
      this.nonFieldErrors,});

  LogInErrorModel.fromJson(dynamic json) {
    nonFieldErrors = json['non_field_errors'] != null ? json['non_field_errors'].cast<String>() : [];
  }
  List<String>? nonFieldErrors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['non_field_errors'] = nonFieldErrors;
    return map;
  }

}