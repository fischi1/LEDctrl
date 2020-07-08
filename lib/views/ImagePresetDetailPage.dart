import 'package:fischi/components/BrightnessPanel.dart';
import 'package:fischi/components/ShadowIcon.dart';
import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/data/sourceImages.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:fischi/domain/preset/Presets.dart';
import 'package:fischi/util/SourceImage.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ImagePresetDetailPage extends StatelessWidget {
  final SourceImage sourceImage;

  const ImagePresetDetailPage({Key key, this.sourceImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = TransparentGradientAppBar(
      title: "Image Preset",
      onBackButtonPressed: () {
        Navigator.of(context).pop();
      },
    );
    return Scaffold(
      appBar: appBar,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.white, Colors.red],
            stops: [0, 0.5, 1],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
//                SizedBox(height: 80),
                  Hero(
                    tag: sourceImage.imagePath,
                    child: FadeInImage(
                      fadeInDuration: Duration(milliseconds: 250),
                      fadeInCurve: Curves.linearToEaseOut,
                      placeholder: MemoryImage(kTransparentImage),
                      image: AssetImage(sourceImage.imagePath),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        child: FlatButton(
                          onPressed: () {},
                          child: ShadowIcon(Icons.swap_horiz),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          if (await canLaunch(sourceImage.url))
                            launch(sourceImage.url);
                        },
                        child: Text(
                          "Photo by ${sourceImage.author} from Pexels",
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                color: const Color.fromARGB(150, 0, 0, 0),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BrightnessPanel(
              value: 0.6,
              onChange: (newVal) {},
              screenHeight: MediaQuery.of(context).size.width,
            )
          ],
        ),
      ),
    );
  }
}
