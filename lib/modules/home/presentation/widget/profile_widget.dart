
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ///DataSource.instance.fetchBooksList();

    return Center(

      child: buildImage(),
    );
  }

  Widget buildImage() {

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onClicked,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: 128,
            height: 128,
          ),
        ),
      ),
    );
  }
}
