import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PresetType {
  simple,
  randomSimple,
  image,
  effectPingPong,
  effectStroboscope,
  effectRainbow
}

Map<PresetType, String> presetTypeNames = {
  PresetType.simple: "Color",
  PresetType.randomSimple: "Random",
  PresetType.image: "Image",
  PresetType.effectPingPong: "Ping Pong",
  PresetType.effectStroboscope: "Stroboscope",
  PresetType.effectRainbow: "Rainbow",
};

Map<PresetType, IconData> presetTypeIcons = {
  PresetType.simple: Icons.web_asset,
  PresetType.randomSimple: Icons.casino,
  PresetType.image: Icons.image,
  PresetType.effectPingPong: Icons.broken_image,
  PresetType.effectStroboscope: Icons.broken_image,
  PresetType.effectRainbow: Icons.broken_image,
};
