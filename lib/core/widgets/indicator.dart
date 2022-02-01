import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final int size;
  final int current;

  const Indicator({Key? key, required this.size, required this.current})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = Iterable<int>.generate(size).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list.map((item) => itemIndicator(item == current)).toList(),
    );
  }

  Widget itemIndicator(bool isActive) {
    return isActive
        ? Container(
            margin: const EdgeInsets.all(2),
            width: 12,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
          )
        : Container(
            margin: const EdgeInsets.all(2),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          );
  }
}
