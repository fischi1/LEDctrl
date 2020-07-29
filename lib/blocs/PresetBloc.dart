import 'dart:convert';

import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/domain/preset/presetMapFromJson.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

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

class PresetBloc extends HydratedBloc<PresetEvent, Map<String, Preset>> {
  PresetBloc() : super({});

  int _lastDeletedPresetIndex = -1;
  Preset _lastDeletedPreset;

  @override
  Stream<Map<String, Preset>> mapEventToState(PresetEvent event) async* {
    if (event is AddPreset) {
      yield Map.of(state)..[event.preset.id] = event.preset;
    } else if (event is UndoDeletePreset) {
      if (_lastDeletedPresetIndex == -1 || _lastDeletedPreset == null)
        yield Map.of(state);

      final Map<String, Preset> newMap = {};
      final entries = state.entries.toList();
      var added = false;
      for (var i = 0; i < state.length; i++) {
        if (i == _lastDeletedPresetIndex) {
          newMap[_lastDeletedPreset.id] = _lastDeletedPreset;
          added = true;
        }
        newMap[entries[i].key] = entries[i].value;
      }

      if (!added) newMap[_lastDeletedPreset.id] = _lastDeletedPreset;

      _lastDeletedPresetIndex = -1;
      _lastDeletedPreset = null;

      yield newMap;
    } else if (event is RemovePreset) {
      final newMap = Map.of(state);
      _lastDeletedPreset = newMap[event.id];
      _lastDeletedPresetIndex =
          state.keys.toList().indexWhere((element) => element == event.id);
      newMap.remove(event.id);
      yield newMap;
    } else if (event is UpdatePreset) {
      yield Map.of(state)..[event.preset.id] = event.preset;
    }
  }

  @override
  Map<String, Preset> fromJson(Map<String, dynamic> json) {
    //TODO 'jsonDecode(json["stored"]' when a newer version for hydrated_bloc is released
    final resultMap = presetMapFromJson(jsonDecode(json["stored"]));
    return resultMap;
  }

  @override
  Map<String, dynamic> toJson(Map<String, Preset> state) {
    final json = state.map(
      (key, value) => MapEntry(
        key,
        value.toJson(),
      ),
    );
    return {"stored": jsonEncode(json)};
  }
}
