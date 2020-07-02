import 'package:bloc/bloc.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:fischi/domain/preset/Presets.dart';
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

class PresetBloc extends Bloc<PresetEvent, List<Preset>> {
  @override
  List<Preset> get initialState => [];

  void _handleAddPresetFromType(PresetType presetType) {}

  @override
  Stream<List<Preset>> mapEventToState(PresetEvent event) async* {
    if (event is AddPreset) {
      yield [...state, event.preset];
    } else if (event is RemovePreset) {
      final newList = [...state];
      newList.removeWhere((item) => item.id == event.id);
      yield newList;
    } else if (event is UpdatePreset) {
      yield state.map((item) {
        if (item.id == event.preset.id) {
          return event.preset;
        }
        return item;
      });
    }
  }
}
