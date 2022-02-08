import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_from_fielid.dart';

class PasswordFormField extends StatefulWidget {
  final String title;
  final String? Function(String?) validator;
  final Function(String?) onSaved;
  final TextEditingController? controller;

  const PasswordFormField(
      {Key? key,
      required this.title,
      required this.validator,
      required this.onSaved,
      this.controller})
      : super(key: key);

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  var isPasswordMode = true;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldApp(
      //color: Colors.blue,

      title: widget.title,
      keyType: TextInputType.visiblePassword,
      validator: widget.validator,
      onSaved: widget.onSaved,
      controller: widget.controller,
      isPassword: isPasswordMode,
      suffixIcon: IconButton(
        onPressed: () => setState(() {
          isPasswordMode = !isPasswordMode;
        }),
        icon: Icon(
          isPasswordMode
              ? Icons.visibility_rounded
              : Icons.visibility_off_rounded,
          color: AppColor.lightBlue,
        ),
      ),
    );
  }
}
