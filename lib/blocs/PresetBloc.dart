import 'package:bloc/bloc.dart';
import 'package:fischi/domain/preset/Preset.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PresetEvent {}

class AddPreset extends PresetEvent {
  final Preset preset;

  AddPreset(this.preset);
}

class RemovePreset extends PresetEvent {
  final String id;

  RemovePreset(this.id);
}

class UpdatePreset extends PresetEvent {
  final Preset preset;

  UpdatePreset(this.preset);
}

class PresetBloc extends Bloc<PresetEvent, Map<String, Preset>> {
  @override
  Map<String, Preset> get initialState => {};

  @override
  Stream<Map<String, Preset>> mapEventToState(PresetEvent event) async* {
    if (event is AddPreset) {
      yield Map.of(state)..[event.preset.id] = event.preset;
    } else if (event is RemovePreset) {
      final newMap = Map.of(state);
      newMap.remove(event.id);
      yield newMap;
    } else if (event is UpdatePreset) {
      yield Map.of(state)..[event.preset.id] = event.preset;
    }
  }
}
