import 'package:flutter/material.dart';

class ValidationErrorText extends StatelessWidget {
  final String error;
  const ValidationErrorText({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomStart,
      child: Text(
        error,
        style: const TextStyle(
          height: 1.2,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}