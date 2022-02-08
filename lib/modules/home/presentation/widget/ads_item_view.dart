import 'package:flutter/material.dart';

class AdsItemView extends StatelessWidget {
  const AdsItemView({
    Key? key,
    required this.image,
    this.action,
  }) : super(key: key);
  final String image;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: action,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
