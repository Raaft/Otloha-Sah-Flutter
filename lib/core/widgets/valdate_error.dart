import 'package:flutter/material.dart';

class FieldValidation extends StatelessWidget {
  final String? error;
  final Widget textField;
  const FieldValidation({
    required this.error,
    required this.textField,
  });
  @override
  Widget build(BuildContext context) {
    print(error);
    return Column(
      children: [
        textField,
        const SizedBox(height: 5),
        error != null
            ? Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  error.toString().substring(1, error.toString().length - 1),
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
