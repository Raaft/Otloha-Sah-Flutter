import 'package:equatable/equatable.dart';

class SubSectionItem extends Equatable {
  final String? subTitle;
  final String title;
  final String image;
  final String? action;
  const SubSectionItem(
      {this.subTitle, required this.title, required this.image, this.action});

  @override
  List<Object?> get props => [title, image, subTitle];
}
