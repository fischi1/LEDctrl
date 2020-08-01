import 'dart:convert';

import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/domain/preset/presetMapFromJson.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PresetBlocState {
  final Map<String, Preset> presetMap;

  PresetBlocState(this.presetMap);
}

@immutable
abstract class PresetEvent {}

class AddPreset extends PresetEvent {
  final Preset preset;

  AddPreset(this.preset);
}

class UndoDeletePreset extends PresetEvent {}

class RemovePreset extends PresetEvent {
  final String id;

  RemovePreset(this.id);
}

class UpdatePreset extends PresetEvent {
  final Preset preset;

  UpdatePreset(this.preset);
}

class ClearAllPresets extends PresetEvent {}

class PresetBloc extends HydratedBloc<PresetEvent, PresetBlocState> {
  PresetBloc() : super(PresetBlocState({}));

  int _lastDeletedPresetIndex = -1;
  Preset _lastDeletedPreset;

  @override
  Stream<PresetBlocState> mapEventToState(PresetEvent event) async* {
    final presetMap = state.presetMap;
    if (event is AddPreset) {
      yield PresetBlocState(presetMap..[event.preset.id] = event.preset);
    } else if (event is UndoDeletePreset) {
      if (_lastDeletedPresetIndex == -1 || _lastDeletedPreset == null)
        yield PresetBlocState(presetMap);

      final Map<String, Preset> newMap = {};
      final entries = presetMap.entries.toList();
      var added = false;
      for (var i = 0; i < presetMap.length; i++) {
        if (i == _lastDeletedPresetIndex) {
          newMap[_lastDeletedPreset.id] = _lastDeletedPreset;
          added = true;
        }
        newMap[entries[i].key] = entries[i].value;
      }

      if (!added) newMap[_lastDeletedPreset.id] = _lastDeletedPreset;

      _lastDeletedPresetIndex = -1;
      _lastDeletedPreset = null;

      yield PresetBlocState(newMap);
    } else if (event is RemovePreset) {
      final newMap = Map.of(presetMap);
      _lastDeletedPreset = newMap[event.id];
      _lastDeletedPresetIndex =
          presetMap.keys.toList().indexWhere((element) => element == event.id);
      newMap.remove(event.id);
      yield PresetBlocState(newMap);
    } else if (event is UpdatePreset) {
      yield PresetBlocState(presetMap..[event.preset.id] = event.preset);
    } else if (event is ClearAllPresets) {
      yield PresetBlocState({});
    }
  }

  @override
  PresetBlocState fromJson(Map<String, dynamic> json) {
    //TODO 'jsonDecode(json["stored"]' when a newer version for hydrated_bloc is released
    final resultMap = presetMapFromJson(jsonDecode(json["stored"]));
    return PresetBlocState(resultMap);
  }

  @override
  Map<String, dynamic> toJson(PresetBlocState state) {
    final json = state.presetMap.map(
      (key, value) => MapEntry(
        key,
        value.toJson(),
      ),
    );
    return {"stored": jsonEncode(json)};
  }
}
