import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/data/sourceImages.dart';
import 'package:fischi/views/ImagePresetDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImagePresetPage extends StatelessWidget {
  List<Widget> _generateGridImages(BuildContext context) {
    return sourceImages
        .map(
          (sourceImage) => Container(
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).push(
                  new CupertinoPageRoute(
                    builder: (context) => ImagePresetDetailPage(
                      sourceImage: sourceImage,
                    ),
                  ),
                );
              },
              padding: EdgeInsets.zero,
              child: Hero(
                tag: sourceImage.imagePath,
                child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: 250),
                  fadeInCurve: Curves.linearToEaseOut,
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(sourceImage.imagePath),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentGradientAppBar(
        title: "Select an image",
        onBackButtonPressed: () {
          Navigator.of(context).pop();
        },
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: GridView.count(
        childAspectRatio: 1.5,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: _generateGridImages(context),
      ),
    );
  }
}
