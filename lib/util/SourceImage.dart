import 'package:fischi/domain/ColorBreakpoint.dart';

class SourceImage {
  final String imagePath;
  final String author;
  final String url;
  final List<ColorBreakpoint> breakpoints;

  SourceImage({
    this.imagePath,
    this.author,
    this.url,
    this.breakpoints,
  });
}
