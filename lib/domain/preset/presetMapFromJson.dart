import 'package:fischi/domain/preset/ColorBreakpointPreset.dart';
import 'package:fischi/domain/preset/ImagePreset.dart';
import 'package:fischi/domain/preset/PingPongPreset.dart';
import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/domain/preset/RainbowPreset.dart';
import 'package:fischi/domain/preset/StroboscopePreset.dart';

Map<String, Preset> presetMapFromJson(Map<dynamic, dynamic> json) {
  return json.map((key, value) {
    Preset preset;

    final classIdentifier = value["classIdentifier"] as String;

    final mappedMap = (value as Map<dynamic, dynamic>)
        .map((key, value) => MapEntry(key as String, value));

    switch (classIdentifier) {
      case "COLOR_BREAKPOINT":
        preset = ColorBreakpointPreset.fromJson(mappedMap);
        break;
      case "IMAGE":
        preset = ImagePreset.fromJson(mappedMap);
        break;
      case "PING_PONG":
        preset = PingPongPreset.fromJson(mappedMap);
        break;
      case "STROBOSCOPE":
        preset = StroboscopePreset.fromJson(mappedMap);
        break;
      case "RAINBOW":
        preset = RainbowPreset.fromJson(mappedMap);
        break;
    }

    return MapEntry(key, preset);
  });
}
