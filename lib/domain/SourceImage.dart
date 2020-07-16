import 'package:fischi/data/sourceImages.dart';
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

  factory SourceImage.fromJson(Map<String, dynamic> json) =>
      sourceImages.firstWhere(
        (elem) => elem.imagePath == (json["imagePath"] as String),
        orElse: null,
      );
  Map<String, dynamic> toJson() => {"imagePath": this.imagePath};
}
