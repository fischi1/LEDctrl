import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:fischi/util/hsvColorJson.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PingPongPreset.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class PingPongPreset extends Preset {
  @JsonKey(fromJson: hsvColorFromJson, toJson: hsvColorToJson)
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
          classIdentifier: "PING_PONG",
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

  factory PingPongPreset.fromJson(Map<String, dynamic> json) =>
      _$PingPongPresetFromJson(json);

  Map<String, dynamic> toJson() => _$PingPongPresetToJson(this);

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
