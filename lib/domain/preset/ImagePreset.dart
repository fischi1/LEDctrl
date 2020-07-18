import 'package:fischi/domain/SourceImage.dart';
import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ImagePreset.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class ImagePreset extends Preset {
  SourceImage sourceImage;

  ImagePreset({
    this.sourceImage,
    String name,
    double brightnessMultiplier,
    String id,
    PresetType presetType,
  }) : super(
          name: name,
          brightnessMultiplier: brightnessMultiplier,
          id: id,
          presetType: presetType,
          classIdentifier: "IMAGE",
        );

  ImagePreset.copy(ImagePreset other)
      : this(
          sourceImage: other.sourceImage,
          name: other.name,
          id: other.id,
          brightnessMultiplier: other.brightnessMultiplier,
          presetType: other.presetType,
        );

  factory ImagePreset.fromJson(Map<String, dynamic> json) =>
      _$ImagePresetFromJson(json);

  Map<String, dynamic> toJson() => _$ImagePresetToJson(this);

  @override
  Preset copy() {
    return ImagePreset(
      sourceImage: sourceImage,
      presetType: presetType,
      brightnessMultiplier: brightnessMultiplier,
      name: name,
      id: id,
    );
  }

  @override
  buildApiPresetData() => {
        "type": "simple",
        "breakpoints": sourceImage.breakpoints?.map((breakpoint) {
          final rgbColor = breakpoint.color.toColor();
          return {
            "color": {
              "r": (rgbColor.red / 255.0) * brightnessMultiplier,
              "g": (rgbColor.green / 255.0) * brightnessMultiplier,
              "b": (rgbColor.blue / 255.0) * brightnessMultiplier,
            },
            "position": breakpoint.position,
          };
        })?.toList(),
      };

  @override
  Gradient buildGradient(
      {Alignment begin = Alignment.topCenter,
      Alignment end = Alignment.bottomLeft}) {
    if (sourceImage == null ||
        sourceImage.breakpoints == null ||
        sourceImage.breakpoints.isEmpty)
      return LinearGradient(
        colors: [const Color.fromARGB(255, 25, 25, 25)],
        stops: [0.5],
      );

    return LinearGradient(
      colors: sourceImage.breakpoints.map((bp) {
        var color = bp.getEffectiveColor();
        return Color.fromARGB(
          255,
          (color.red * brightnessMultiplier).floor(),
          (color.green * brightnessMultiplier).floor(),
          (color.blue * brightnessMultiplier).floor(),
        );
      }).toList(),
      stops: sourceImage.breakpoints.map((bp) => bp.position).toList(),
      begin: begin,
      end: end,
    );
  }
}
