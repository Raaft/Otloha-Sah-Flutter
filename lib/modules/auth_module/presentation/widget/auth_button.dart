import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final double width;
  final Function onPressed;
  final List<Color> colors;

  const AuthButton({
    required this.buttonText,
    required this.width,
    required this.onPressed,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 1.0],
              colors: colors,
            ),
            color: Colors.deepPurple.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              minimumSize: MaterialStateProperty.all(Size(width, 50)),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              // elevation: MaterialStateProperty.all(3),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              onPressed();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ));
  }
}
class UploadButton extends StatelessWidget {
  final String buttonText;
  final double width;
  final Function onPressed;
  final List<Color> colors;

  const UploadButton({
    required this.buttonText,
    required this.width,
    required this.onPressed,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:  EdgeInsets.all(10.0),
        child: OutlinedButton(

          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: BorderSide(width: 1, color: AppColor.lightBlue),
          ),
          onPressed: () => onPressed(),
          child: Text(buttonText,style: TextStyle(color: AppColor.lightBlue),),
        ));
  }
}
