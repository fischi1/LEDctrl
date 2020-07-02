import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:fischi/domain/preset/Presets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

Preset presetTypeToPreset(BuildContext context, PresetType presetType) {
  int presetCount = context.bloc<PresetBloc>().state.length;
  switch (presetType) {
    case PresetType.simple:
      return ColorBreakpointPreset(
        id: Uuid().v4(),
        name: "Preset #${presetCount + 1}",
        breakpoints: [],
        brightnessMultiplier: 1,
        presetType: presetType,
      );
      break;
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
