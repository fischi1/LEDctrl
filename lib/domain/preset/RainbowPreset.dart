import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:fischi/util/normalizedBrightnessTransform.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'RainbowPreset.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class RainbowPreset extends Preset {
  int width;
  int ledsPerSecond;

  RainbowPreset({
    this.width,
    this.ledsPerSecond,
    String name,
    double brightnessMultiplier,
    String id,
    PresetType presetType,
  }) : super(
          name: name,
          brightnessMultiplier: brightnessMultiplier,
          id: id,
          presetType: presetType,
          classIdentifier: "RAINBOW",
        );

  RainbowPreset.copy(RainbowPreset other)
      : this(
          width: other.width,
          ledsPerSecond: other.ledsPerSecond,
          name: other.name,
          id: other.id,
          brightnessMultiplier: other.brightnessMultiplier,
          presetType: other.presetType,
        );

  factory RainbowPreset.fromJson(Map<String, dynamic> json) =>
      _$RainbowPresetFromJson(json);

  Map<String, dynamic> toJson() => _$RainbowPresetToJson(this);

  @override
  Preset copy() {
    return RainbowPreset(
      width: width,
      ledsPerSecond: ledsPerSecond,
      presetType: presetType,
      brightnessMultiplier: brightnessMultiplier,
      name: name,
      id: id,
    );
  }

  @override
  buildApiPresetData() => {
        "type": "effect",
        "effect": {
          "type": "rainbow",
          "props": {
            "width": width,
            "ledsPerSecond": ledsPerSecond,
            "brightness": normalizedBrightnessTransform(brightnessMultiplier),
          }
        }
      };

  @override
  Gradient buildGradient({
    Alignment begin = Alignment.topCenter,
    Alignment end = Alignment.bottomLeft,
  }) {
    final colorVal = (255 * brightnessMultiplier).floor();
    return LinearGradient(
      colors: [
        Color.fromARGB(255, colorVal, 0, 0),
        Color.fromARGB(255, colorVal, colorVal, 0),
        Color.fromARGB(255, 0, colorVal, 0),
        Color.fromARGB(255, 0, colorVal, colorVal),
        Color.fromARGB(255, 0, 0, colorVal),
      ],
      stops: [
        0,
        0.3,
        0.5,
        0.7,
        1,
      ],
      begin: begin,
      end: end,
    );
  }
}
