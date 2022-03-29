import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/constant/constants.dart';

class CachedImage extends StatefulWidget {
  final String url;
  final double raduis;

  const CachedImage({
    required this.url,
    required this.raduis,
  });
  @override
  _CachedImageState createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.raduis,
      backgroundColor: Colors.grey[300],
      child: CachedNetworkImage(
        imageUrl: '$baseUrl${widget.url}',
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/user_img.png',
        ),
      ),
    );
  }
}
