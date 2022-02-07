import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';

class TextFormFieldApp extends StatelessWidget {
  TextFormFieldApp({
    Key? key,
    required this.title,
    this.keyType = TextInputType.name,
    required this.validator,
    required this.onSaved,
    this.controller,
    this.isPassword = false,
    this.isEnabled = true,
    this.suffixIcon,
    this.prefixIcon,
    this.value,
    this.color,
  }) : super(key: key);

  final bool isPassword;
  final bool isEnabled;
  final String title;
  final String? value;
  final TextInputType keyType;
  final String? Function(String?) validator;
  final Function(String?) onSaved;
  TextEditingController? controller;
  Widget? prefixIcon;
  Widget? suffixIcon;
  Color? color;

  @override
  Widget build(BuildContext context) {
    var borderSide =
        BorderSide(width: 2, color: Theme.of(context).primaryColor);

    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: borderSide,
    );
    color = color ?? AppColor.txtColor3;

    var style = TextStyle(fontSize: 16, color: color);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: value,
        enabled: isEnabled,
        obscureText: isPassword,
        controller: controller,
        key: ValueKey(key),
        decoration: InputDecoration(
          filled: true,
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border,
          focusedErrorBorder: border,
          disabledBorder: border,
          labelStyle: style.copyWith(color: color),
          labelText: title,
          hintStyle: style,
          hintText: title,
          fillColor: Theme.of(context).canvasColor,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        keyboardType: keyType,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
