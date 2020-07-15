import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:fischi/domain/SourceImage.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

abstract class Preset {
  String id;
  String name;
  double brightnessMultiplier;
  PresetType presetType;

  Preset({
    this.name,
    this.brightnessMultiplier,
    this.id,
    this.presetType,
  });

  Preset copy();

  dynamic buildApiPresetData();

  Gradient buildGradient({
    Alignment begin = Alignment.topCenter,
    Alignment end = Alignment.bottomLeft,
  }) {
    return LinearGradient(
      colors: [Colors.black],
      stops: [0.5],
      begin: begin,
      end: end,
    );
  }
}

class ColorBreakpointPreset extends Preset {
  List<ColorBreakpoint> breakpoints;

  ColorBreakpointPreset({
    this.breakpoints,
    String name,
    double brightnessMultiplier,
    String id,
    PresetType presetType,
  }) : super(
          name: name,
          brightnessMultiplier: brightnessMultiplier,
          id: id,
          presetType: presetType,
        );

  ColorBreakpointPreset.copy(ColorBreakpointPreset other)
      : this(
          breakpoints: other.breakpoints,
          name: other.name,
          id: other.id,
          brightnessMultiplier: other.brightnessMultiplier,
          presetType: other.presetType,
        );

  @override
  Preset copy() {
    return ColorBreakpointPreset(
      breakpoints: breakpoints,
      presetType: presetType,
      brightnessMultiplier: brightnessMultiplier,
      name: name,
      id: id,
    );
  }

  @override
  buildApiPresetData() => {
        "type": "simple",
        "breakpoints": breakpoints.map((breakpoint) {
          final rgbColor = breakpoint.color.toColor();
          return {
            "color": {
              "r": (rgbColor.red / 255.0) * brightnessMultiplier,
              "g": (rgbColor.green / 255.0) * brightnessMultiplier,
              "b": (rgbColor.blue / 255.0) * brightnessMultiplier,
            },
            "position": breakpoint.position,
          };
        }).toList(),
      };

  @override
  Gradient buildGradient(
      {Alignment begin = Alignment.topCenter,
      Alignment end = Alignment.bottomLeft}) {
    if (breakpoints == null || breakpoints.isEmpty)
      return LinearGradient(
        colors: [const Color.fromARGB(255, 25, 25, 25)],
        stops: [0.5],
      );

    return LinearGradient(
      colors: breakpoints.map((bp) {
        var color = bp.getEffectiveColor();
        return Color.fromARGB(
          255,
          (color.red * brightnessMultiplier).floor(),
          (color.green * brightnessMultiplier).floor(),
          (color.blue * brightnessMultiplier).floor(),
        );
      }).toList(),
      stops: breakpoints.map((bp) => bp.position).toList(),
      begin: begin,
      end: end,
    );
  }
}

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
        );

  ImagePreset.copy(ImagePreset other)
      : this(
          sourceImage: other.sourceImage,
          name: other.name,
          id: other.id,
          brightnessMultiplier: other.brightnessMultiplier,
          presetType: other.presetType,
        );

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

class PingPongPreset extends Preset {
  HSVColor color;
  int radius;
  double transitionTime;

  PingPongPreset({
    this.color,
    this.radius,
    this.transitionTime,
    String name,
    double brightnessMultiplier,
    String id,
    PresetType presetType,
  }) : super(
          name: name,
          brightnessMultiplier: brightnessMultiplier,
          id: id,
          presetType: presetType,
        );

  PingPongPreset.copy(PingPongPreset other)
      : this(
          color: other.color,
          radius: other.radius,
          transitionTime: other.transitionTime,
          name: other.name,
          id: other.id,
          brightnessMultiplier: other.brightnessMultiplier,
          presetType: other.presetType,
        );

  @override
  Preset copy() {
    return PingPongPreset(
      color: color,
      radius: radius,
      transitionTime: transitionTime,
      presetType: presetType,
      brightnessMultiplier: brightnessMultiplier,
      name: name,
      id: id,
    );
  }

  @override
  buildApiPresetData() {
    final rgbColor = color.toColor();
    return {
      "type": "effect",
      "effect": {
        "type": "pingPong",
        "props": {
          "radius": radius,
          "transitionTime": transitionTime,
          "color": {
            "r": (rgbColor.red / 255.0) * brightnessMultiplier,
            "g": (rgbColor.green / 255.0) * brightnessMultiplier,
            "b": (rgbColor.blue / 255.0) * brightnessMultiplier,
          },
        }
      }
    };
  }

  @override
  Gradient buildGradient({
    Alignment begin = Alignment.topCenter,
    Alignment end = Alignment.bottomLeft,
  }) {
    var rgbColor = color.toColor();
    rgbColor = Color.fromARGB(
      255,
      (rgbColor.red * brightnessMultiplier).floor(),
      (rgbColor.green * brightnessMultiplier).floor(),
      (rgbColor.blue * brightnessMultiplier).floor(),
    );
    return LinearGradient(
      colors: [Colors.transparent, rgbColor, Colors.transparent],
      stops: [0, 0.5, 1],
      begin: begin,
      end: end,
    );
  }
}
