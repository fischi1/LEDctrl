import 'package:fischi/util/hsvColorJson.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'ColorBreakpoint.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class ColorBreakpoint {
  String id = Uuid().v4();

  @JsonKey(fromJson: hsvColorFromJson, toJson: hsvColorToJson)
  HSVColor color;

  ///gradient position 0 to 1
  double position;

  ColorBreakpoint({
    this.color,
    this.position = 0,
  });

  factory ColorBreakpoint.fromJson(Map<String, dynamic> json) =>
      _$ColorBreakpointFromJson(json);
  Map<String, dynamic> toJson() => _$ColorBreakpointToJson(this);

  ColorBreakpoint.copy(ColorBreakpoint toCopy) {
    this.id = toCopy.id;
    this.color = toCopy.color;
    this.position = toCopy.position;
  }

  Color getEffectiveColor() {
    return color.toColor();
  }

  int compare(ColorBreakpoint another) {
    if (this.position > another.position) return 1;
    if (this.position < another.position) return -1;
    return 0;
  }

  @override
  String toString() {
    return 'ColorBreakpoint{id: $id, color: $color, position: $position}';
  }
}
