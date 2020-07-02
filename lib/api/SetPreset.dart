import 'dart:convert';

import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:http/http.dart' as http;

class SetPreset {
  var _client = http.Client();

  Future<http.Response> _futureResponse;

  List<ColorBreakpoint> _bufferedBreakpoints;

  void setSimple(String url, List<ColorBreakpoint> breakpoints) {
    _bufferedBreakpoints = List.of(breakpoints);
    if (_futureResponse == null) sendSimple(url);
  }

  void sendSimple(String url) {
    if (_bufferedBreakpoints == null) return;

    _bufferedBreakpoints.sort(_compare);
    final data = {
      "type": "simple",
      "breakpoints": _bufferedBreakpoints.map(_convertBreakpoint).toList(),
    };

    _futureResponse = _client.post(
      "$url/set",
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    _bufferedBreakpoints = null;

    _futureResponse.whenComplete(() {
      _futureResponse = null;
      if (_bufferedBreakpoints != null) sendSimple(url);
    });
  }

  dynamic _convertBreakpoint(ColorBreakpoint breakpoint) {
    final rgbColor = breakpoint.color.toColor();
    return {
      "color": {
        "r": (rgbColor.red / 255.0),
        "g": (rgbColor.green / 255.0),
        "b": (rgbColor.blue / 255.0),
      },
      "position": breakpoint.position,
    };
  }

  int _compare(ColorBreakpoint a, ColorBreakpoint b) => a.compare(b);
}
