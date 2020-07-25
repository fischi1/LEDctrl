import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:fischi/util/hsvColorJson.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'StroboscopePreset.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class StroboscopePreset extends Preset {
  @JsonKey(fromJson: hsvColorFromJson, toJson: hsvColorToJson)
  HSVColor color;
  double toggleDuration;

  StroboscopePreset({
    this.color,
    this.toggleDuration,
    String name,
    double brightnessMultiplier,
    String id,
    PresetType presetType,
  }) : super(
          name: name,
          brightnessMultiplier: brightnessMultiplier,
          id: id,
          presetType: presetType,
          classIdentifier: "STROBOSCOPE",
        );

  StroboscopePreset.copy(StroboscopePreset other)
      : this(
          color: other.color,
          toggleDuration: other.toggleDuration,
          name: other.name,
          id: other.id,
          brightnessMultiplier: other.brightnessMultiplier,
          presetType: other.presetType,
        );

  factory StroboscopePreset.fromJson(Map<String, dynamic> json) =>
      _$StroboscopePresetFromJson(json);

  Map<String, dynamic> toJson() => _$StroboscopePresetToJson(this);

  @override
  Preset copy() {
    return StroboscopePreset(
      color: color,
      toggleDuration: toggleDuration,
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
        "type": "stroboscope",
        "props": {
          "toggleDuration": toggleDuration,
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
      colors: [rgbColor],
      stops: [0],
      begin: begin,
      end: end,
    );
  }
}
