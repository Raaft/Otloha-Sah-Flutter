import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class SubSectionItem extends Equatable {
  final String? subTitle;
  final String title;
  final String image;
  final String? action;
  final Function(BuildContext)? action2;
  const SubSectionItem(
      {this.subTitle,
      required this.title,
      required this.image,
      this.action,
      this.action2});

  @override
  List<Object?> get props => [title, image, subTitle];
}
