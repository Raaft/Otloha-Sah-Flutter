import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextFormFieldApp extends StatelessWidget {
  const TextFormFieldApp(
      {Key? key,
      required this.title,
      this.keyType = TextInputType.name,
      required this.validator,
      //required this.onSaved,
      this.controller,
      this.isPassword = false,
      this.isEnabled = true,
      this.suffixIcon,
      this.prefixIcon,
      this.value,
      this.color})
      : super(key: key);

  final bool isPassword;
  final bool isEnabled;
  final String title;
  final String? value;
  final TextInputType keyType;
  final String? Function(String?) validator;

  // final Function(String?) onSaved;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var borderSide = BorderSide(width: 1, color: AppColor.lightBlue);

    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: borderSide,
    );

    var style = TextStyle(fontSize: 16, color: color);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(color: AppColor.lightBlue),
        initialValue: value,
        enabled: isEnabled,
        obscureText: isPassword,
        controller: controller,
        key: ValueKey(key),
        decoration: InputDecoration(
          //  color: Colors.blue,
          isDense: true,
          //  contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
          filled: true,
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border,
          focusedErrorBorder: border,
          disabledBorder: border,
          labelStyle: style.copyWith(color: color),
          labelText: title,

          //hintStyle: style,
          // hintText: title,
          fillColor: AppColor.white,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        keyboardType: keyType,
        validator: validator,
        //onSaved: onSaved,
      ),
    );
  }
}

var border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(width: 1, color: AppColor.lightBlue),
);

customFormField(
    {required String title,
    String? Function(String?)? validator,
    TextEditingController? controller,
    TextInputType? keyboardType}) {
  return FormBuilderTextField(
    // color: AppColor.lightBlue,
    controller: controller,
    // keyType: TextInputType.emailAddress,
    validator: validator,
    name: title,

    keyboardType: keyboardType,
    decoration: InputDecoration(
      //color: Colors.blue,
      isDense: true,
      fillColor: Colors.blue.withOpacity(.0),
      //color: Colors.blue,

      //  contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
      filled: true,
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border,
      focusedErrorBorder: border,
      disabledBorder: border,
      labelStyle: TextStyle(color: AppColor.lightBlue),
      labelText: title,
    ),
  );
}
