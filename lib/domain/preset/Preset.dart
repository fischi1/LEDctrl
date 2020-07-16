import 'package:fischi/domain/preset/PresetType.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

abstract class Preset {
  String id;
  String name;
  double brightnessMultiplier;
  PresetType presetType;
  String classIdentifier;

  Preset({
    this.name,
    this.brightnessMultiplier,
    this.id,
    this.presetType,
    this.classIdentifier,
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
