import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:fischi/domain/preset/Presets.dart';
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
    case PresetType.image:
      return ImagePreset(
        id: Uuid().v4(),
        name: "Preset #${presetCount + 1}",
        sourceImage: null,
        presetType: presetType,
        brightnessMultiplier: 1,
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
