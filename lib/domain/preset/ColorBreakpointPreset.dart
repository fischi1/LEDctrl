import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ColorBreakpointPreset.g.dart';

@JsonSerializable()
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
          classIdentifier: "COLOR_BREAKPOINT",
        );

  ColorBreakpointPreset.copy(ColorBreakpointPreset other)
      : this(
          breakpoints: other.breakpoints,
          name: other.name,
          id: other.id,
          brightnessMultiplier: other.brightnessMultiplier,
          presetType: other.presetType,
        );

  factory ColorBreakpointPreset.fromJson(Map<String, dynamic> json) =>
      _$ColorBreakpointPresetFromJson(json);

  Map<String, dynamic> toJson() => _$ColorBreakpointPresetToJson(this);

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
