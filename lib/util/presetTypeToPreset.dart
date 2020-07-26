import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:fischi/domain/preset/ColorBreakpointPreset.dart';
import 'package:fischi/domain/preset/ImagePreset.dart';
import 'package:fischi/domain/preset/PingPongPreset.dart';
import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:fischi/domain/preset/RainbowPreset.dart';
import 'package:fischi/domain/preset/StroboscopePreset.dart';
import 'package:fischi/util/randomColorBreakpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

Preset presetTypeToPreset(BuildContext context, PresetType presetType) {
  int presetCount = context.bloc<PresetBloc>().state.length;
  switch (presetType) {
    case PresetType.simple:
      return ColorBreakpointPreset(
        id: Uuid().v4(),
        name: "Preset #${presetCount + 1}",
        breakpoints: [
          ColorBreakpoint(
            color: HSVColor.fromColor(Colors.orange),
            position: 0.1,
          ),
          ColorBreakpoint(
            color: HSVColor.fromColor(Colors.purple),
            position: 0.9,
          )
        ],
        brightnessMultiplier: 1,
        presetType: presetType,
      );
      break;
    case PresetType.randomSimple:
      return ColorBreakpointPreset(
        id: Uuid().v4(),
        name: "Preset #${presetCount + 1}",
        breakpoints: randomColorBreakpoints(),
        brightnessMultiplier: 1,
        presetType: presetType,
      );
      break;
    case PresetType.image:
      return ImagePreset(
        id: Uuid().v4(),
        name: "Preset #${presetCount + 1}",
        brightnessMultiplier: 1,
        presetType: presetType,
        sourceImage: null,
      );
    case PresetType.effectPingPong:
      return PingPongPreset(
        id: Uuid().v4(),
        name: "Preset #${presetCount + 1}",
        brightnessMultiplier: 1,
        presetType: presetType,
        radius: 15,
        transitionTime: 2.5,
        color: HSVColor.fromColor(Colors.cyan),
      );
    case PresetType.effectStroboscope:
      return StroboscopePreset(
        id: Uuid().v4(),
        name: "Preset #${presetCount + 1}",
        brightnessMultiplier: 1,
        presetType: presetType,
        toggleDuration: 0.25,
        color: HSVColor.fromColor(Colors.white),
      );
    case PresetType.effectRainbow:
      return RainbowPreset(
        id: Uuid().v4(),
        name: "Preset #${presetCount + 1}",
        brightnessMultiplier: 1,
        presetType: presetType,
        width: 30,
        ledsPerSecond: 50,
      );
    default:
      print("no case for $presetType in presetTypeToPreset");
      return ColorBreakpointPreset(
        id: Uuid().v4(),
        name: "Preset #${presetCount + 1}",
        breakpoints: [],
        brightnessMultiplier: 1,
        presetType: presetType,
      );
  }
}
