import 'dart:convert';

import 'package:fischi/api/Toggle.dart';
import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:http/http.dart' as http;

class SetPreset {
  static int counter = 0;

  static dynamic _convertBreakpoint(ColorBreakpoint breakpoint) {
    return {
      "color": {
        "r": (breakpoint.color.red / 255.0) * breakpoint.brightnessMultiplier,
        "g": (breakpoint.color.green / 255.0) * breakpoint.brightnessMultiplier,
        "b": (breakpoint.color.blue / 255.0) * breakpoint.brightnessMultiplier,
      },
      "position": breakpoint.position,
    };
  }

  static int _compare(ColorBreakpoint a, ColorBreakpoint b) => a.compare(b);

  static void setSimple(List<ColorBreakpoint> breakpoints) {
    counter++;

    if (counter % 50 != 0) return;

    final bpList = List.of(breakpoints);
    bpList.sort(_compare);
    final data = {
      "type": "simple",
      "breakpoints": bpList.map(_convertBreakpoint).toList(),
    };
    print("data");
    http.post(
      "$baseUrl/set",
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
  }
}
