import 'package:flutter/material.dart';

Map<String, double> hsvColorToJson(HSVColor color) => {
      "hue": color.hue,
      "saturation": color.saturation,
      "value": color.value,
    };

HSVColor hsvColorFromJson(Map<String, dynamic> json) {
  return HSVColor.fromAHSV(
    1,
    json["hue"] as double,
    json["saturation"] as double,
    json["value"] as double,
  );
}
