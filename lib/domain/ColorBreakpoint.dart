import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ColorBreakpoint {
  String id = Uuid().v4();

  Color color;

  ///gradient position 0 to 1
  double value;

  ColorBreakpoint({
    this.color = Colors.white,
    this.value = 0,
  });

  ColorBreakpoint.copy(ColorBreakpoint toCopy) {
    this.id = toCopy.id;
    this.color = toCopy.color;
    this.value = toCopy.value;
  }

  @override
  String toString() {
    return 'ColorBreakpoint{id: $id, color: $color, value: $value}';
  }
}
