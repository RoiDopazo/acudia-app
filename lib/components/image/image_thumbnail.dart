import 'package:acudia/colors.dart';
import 'package:flutter/material.dart';

class AcudiaImageThumbnail extends StatelessWidget {
  final String photoUrl;
  final String fallbackText;

  const AcudiaImageThumbnail({Key key, this.photoUrl, this.fallbackText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasImage = photoUrl != null && photoUrl != '';

    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: !hasImage ? aCPalette.shade600 : null,
        shape: BoxShape.circle,
        image: hasImage ? DecorationImage(image: new NetworkImage(photoUrl), fit: BoxFit.fill) : null,
      ),
      child: !hasImage
          ? Center(
              child:
                  Text(fallbackText, style: TextStyle(fontSize: 22, color: Theme.of(context).scaffoldBackgroundColor)))
          : null,
    );
  }
}
