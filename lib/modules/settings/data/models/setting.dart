class Settings {
  final String name;
  final String? subTitle;
  final String image;
  final String? actionTo;

  Settings({
    required this.name,
    required this.image,
    this.subTitle,
    this.actionTo,
  });
}
