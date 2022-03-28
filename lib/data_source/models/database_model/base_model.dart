abstract class BaseModel{
  BaseModel.fromJson(Map<String, dynamic>? json);
  BaseModel();
  Map<String, dynamic> toJson();
}