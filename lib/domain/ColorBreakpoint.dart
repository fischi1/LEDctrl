import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ColorBreakpoint {
  String id = Uuid().v4();

  Color color;

  double brightnessMultiplier;

  ///gradient position 0 to 1
  double position;

  ColorBreakpoint({
    this.color = Colors.white,
    this.position = 0,
    this.brightnessMultiplier = 1,
  });

  ColorBreakpoint.copy(ColorBreakpoint toCopy) {
    this.id = toCopy.id;
    this.color = toCopy.color;
    this.position = toCopy.position;
    this.brightnessMultiplier = toCopy.brightnessMultiplier;
  }

  Color getEffectiveColor() {
    return Color.fromARGB(
      255,
      (color.red * brightnessMultiplier).floor(),
      (color.green * brightnessMultiplier).floor(),
      (color.blue * brightnessMultiplier).floor(),
    );
  }

  @override
  String toString() {
    return 'ColorBreakpoint{id: $id, color: $color, position: $position}';
  }
}
