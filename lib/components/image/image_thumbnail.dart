import 'package:acudia/colors.dart';
import 'package:flutter/material.dart';

const LARGE_SIZE = 75.0;
const SMALL_SIZE = 40.0;

class AcudiaImageThumbnail extends StatelessWidget {
  final String photoUrl;
  final String fallbackText;
  final bool small;

  const AcudiaImageThumbnail({Key key, this.photoUrl, this.fallbackText, this.small = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasImage = photoUrl != null && photoUrl != '';

    return Container(
      width: small ? SMALL_SIZE : LARGE_SIZE,
      height: small ? SMALL_SIZE : LARGE_SIZE,
      decoration: BoxDecoration(
        color: !hasImage ? aCPalette.shade600 : null,
        shape: BoxShape.circle,
        image: hasImage ? DecorationImage(image: new NetworkImage(photoUrl), fit: BoxFit.fill) : null,
      ),
      child: !hasImage
          ? Center(
              child: Text(fallbackText,
                  style: TextStyle(fontSize: small ? 18 : 22, color: Theme.of(context).scaffoldBackgroundColor)))
          : null,
    );
  }
}
