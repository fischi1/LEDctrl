import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

@immutable
abstract class Preset {
  final String id;
  final String name;
  final double brightnessMultiplier;
  final PresetType presetType;

  Preset({
    this.name,
    this.brightnessMultiplier,
    this.id,
    this.presetType,
  });

  Preset.copy(Preset other)
      : this(
          name: other.name,
          id: other.id,
          brightnessMultiplier: other.brightnessMultiplier,
          presetType: other.presetType,
        );

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
  final List<ColorBreakpoint> breakpoints;

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

  @override
  Gradient buildGradient(
      {Alignment begin = Alignment.topCenter,
      Alignment end = Alignment.bottomLeft}) {
    return LinearGradient(
      colors: breakpoints.map((bp) => bp.getEffectiveColor()).toList(),
      stops: breakpoints.map((bp) => bp.position).toList(),
      begin: begin,
      end: end,
    );
  }
}
