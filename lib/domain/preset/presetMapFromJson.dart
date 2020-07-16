import 'dart:convert';

import 'package:fischi/domain/preset/ColorBreakpointPreset.dart';
import 'package:fischi/domain/preset/ImagePreset.dart';
import 'package:fischi/domain/preset/PingPongPreset.dart';
import 'package:fischi/domain/preset/Preset.dart';

Map<String, Preset> presetMapFromJson(String json) {
  final Map<String, dynamic> map = jsonDecode(json);

  return map.map((key, value) {
    Preset preset;

    switch (value["classIdentifier"]) {
      case "COLOR_BREAKPOINT":
        preset = ColorBreakpointPreset.fromJson(value);
        break;
      case "IMAGE":
        preset = ImagePreset.fromJson(value);
        break;
      case "PING_PONG":
        preset = PingPongPreset.fromJson(value);
        break;
    }

    return MapEntry(
      key,
      preset,
    );
  });
}
