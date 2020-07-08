import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/util/SourceImage.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ImagePresetDetailPage extends StatelessWidget {
  final SourceImage sourceImage;

  const ImagePresetDetailPage({Key key, this.sourceImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentGradientAppBar(
        title: "Image Preset",
        onBackButtonPressed: () {
          Navigator.of(context).pop();
        },
      ),
      extendBody: true,
      body: Column(
        children: <Widget>[
          Hero(
            tag: sourceImage.imagePath,
            child: FadeInImage(
              fadeInDuration: Duration(milliseconds: 250),
              fadeInCurve: Curves.linearToEaseOut,
              placeholder: MemoryImage(kTransparentImage),
              image: AssetImage(sourceImage.imagePath),
            ),
          ),
          Container(
            height: 80,
            width: double.infinity,
            color: Colors.lightBlue,
          ),
          FlatButton(
            onPressed: () async {
              if (await canLaunch(sourceImage.url)) launch(sourceImage.url);
            },
            child: Text("Photo by ${sourceImage.author} from Pexels"),
          )
        ],
      ),
    );
  }
}
