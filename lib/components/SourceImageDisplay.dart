import 'package:fischi/components/ShadowIcon.dart';
import 'package:fischi/util/SourceImage.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class SourceImageDisplay extends StatelessWidget {
  final SourceImage sourceImage;
  final Function onChangeImage;

  const SourceImageDisplay({
    Key key,
    this.sourceImage,
    this.onChangeImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                onPressed: onChangeImage,
                child: ShadowIcon(Icons.swap_horiz),
                padding: EdgeInsets.zero,
              ),
            ),
            FlatButton(
              onPressed: () async {
                if (await canLaunch(sourceImage.url)) launch(sourceImage.url);
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
    );
  }
}
