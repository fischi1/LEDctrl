import 'package:fischi/components/LedAppPage.dart';
import 'package:fischi/data/sourceImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ChooseImagePage extends StatelessWidget {
  List<Widget> _generateGridImages(BuildContext context) {
    return sourceImages
        .map(
          (sourceImage) => Container(
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pop(sourceImage);
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
    return LedAppPage(
      title: "Select an image",
      navigatorPopOnBack: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      child: GridView.count(
        childAspectRatio: 1.5,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: _generateGridImages(context),
      ),
    );
  }
}
