import 'package:fischi/domain/ColorBreakpoint.dart';
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
  Gradient buildGradient(
      {Alignment begin = Alignment.topCenter,
      Alignment end = Alignment.bottomLeft}) {
    if (breakpoints == null || breakpoints.isEmpty)
      return LinearGradient(
        colors: [const Color.fromARGB(255, 25, 25, 25)],
        stops: [0.5],
      );

    return LinearGradient(
      colors: breakpoints.map((bp) => bp.getEffectiveColor()).toList(),
      stops: breakpoints.map((bp) => bp.position).toList(),
      begin: begin,
      end: end,
    );
  }
}
