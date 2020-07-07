import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/data/sourceImages.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImagePresetPage extends StatelessWidget {
  List<Widget> _generateGridImages() {
    return sourceImages
        .map(
          (sourceImage) => Container(
            child: FlatButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              child: FadeInImage(
                fadeInDuration: Duration(milliseconds: 250),
                fadeInCurve: Curves.linearToEaseOut,
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(sourceImage.imagePath),
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
        children: _generateGridImages(),
      ),
    );
  }
}
