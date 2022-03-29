import 'dart:convert';

import 'package:flutter/widgets.dart';
import '../../../core/utils/themes/color.dart';

class ErrorType {
  static List<ErrorType> errors = [
    ErrorType(key: 'pronunciation', value: 'النطق', color: AppColor.conColorO),
    ErrorType(key: 'word', value: 'الكلمة', color: AppColor.lightYellow),
    ErrorType(key: 'tajweed', value: 'ا لتجويد', color: AppColor.txtColor5),
  ];

  String key;
  String? value;
  Color color;
  ErrorType({
    required this.key,
    required this.value,
    required this.color,
  });

  ErrorType copyWith({
    String? key,
    String? value,
    Color? color,
  }) {
    return ErrorType(
      key: key ?? this.key,
      value: value ?? this.value,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'value': value,
      'color': color.value,
    };
  }

  factory ErrorType.fromMap(Map<String, dynamic> map) {
    return ErrorType(
      key: map['key'] ?? '',
      value: map['value'] ?? '',
      color: Color(map['color']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorType.fromJson(String source) =>
      ErrorType.fromMap(json.decode(source));

  @override
  String toString() => 'ErrorType(key: $key, value: $value, color: $color)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorType &&
        other.key == key &&
        other.value == value &&
        other.color == color;
  }

  @override
  int get hashCode => key.hashCode ^ value.hashCode ^ color.hashCode;
}
