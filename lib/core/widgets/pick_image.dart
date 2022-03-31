import 'dart:io';

import 'package:flutter/material.dart';
import '../utils/res/icons_app.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage({
    Key? key,
    required this.action,
    this.isEnabled = true,
    this.imageLink,
  }) : super(key: key);

  final Function(File?) action;

  final bool isEnabled;
  final String? imageLink;

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? _image;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();

    if (widget.imageLink != null) {
      _image = File(widget.imageLink ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(12),
        width: 150,
        height: 150,
        child: GestureDetector(
          onTap: widget.isEnabled ? _getImage : null,
          child: CircleAvatar(
            radius: 75,
            backgroundColor: Colors.transparent,
            backgroundImage: (_image != null
                ? FileImage(_image!)
                : AssetImage(AppIcons.userIcon) as ImageProvider),
          ),
        ),
      ),
    );
  }

  _getImage({ImageSource source = ImageSource.gallery}) async {
    //  final PickedFile? pickedFile = await _imagePicker.getImage( source: source, imageQuality: 50, maxHeight: 200);
    final pickedFile = await _imagePicker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.action(_image!);
      }
    });
  }
}
