/// addresser : 1
/// addressee : 1
/// accepted_at : ""
/// is_read : true
/// is_sent : true
/// recitation : 1

// ignore_for_file: file_names

class MessageModel {
  MessageModel({
      this.addresser, 
      this.addressee, 
      this.acceptedAt, 
      this.isRead, 
      this.isSent, 
      this.recitation,});

  MessageModel.fromJson(dynamic json) {
    addresser = json['addresser'];
    addressee = json['addressee'];
    acceptedAt = json['accepted_at'];
    isRead = json['is_read'];
    isSent = json['is_sent'];
    recitation = json['recitation'];
  }
  int? addresser;
  int? addressee;
  String? acceptedAt;
  bool? isRead;
  bool? isSent;
  int? recitation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['addresser'] = addresser;
    map['addressee'] = addressee;
    map['accepted_at'] = acceptedAt;
    map['is_read'] = isRead;
    map['is_sent'] = isSent;
    map['recitation'] = recitation;
    return map;
  }

}