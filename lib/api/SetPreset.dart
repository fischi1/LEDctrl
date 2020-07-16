import 'dart:convert';

import 'package:fischi/domain/preset/Preset.dart';
import 'package:http/http.dart' as http;

class SetPreset {
  var _client = http.Client();

  Future<http.Response> _futureResponse;

  Preset _bufferedPreset;

  void setSimple(String url, Preset preset) {
    _bufferedPreset = preset;
    if (_futureResponse == null) sendSimple(url);
  }

  void sendSimple(String url) {
    if (_bufferedPreset == null) return;

    _futureResponse = _client.post(
      "$url/set",
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(_bufferedPreset.buildApiPresetData()),
    );

    _bufferedPreset = null;

    _futureResponse.whenComplete(() {
      _futureResponse = null;
      if (_bufferedPreset != null) sendSimple(url);
    });
  }
}
