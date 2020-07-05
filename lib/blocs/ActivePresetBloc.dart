import 'package:bloc/bloc.dart';
import 'package:fischi/api/SetPreset.dart';
import 'package:fischi/blocs/SettingsBloc.dart';
import 'package:fischi/domain/preset/Presets.dart';

class ActivePresetState {
  Preset preset;

  ActivePresetState(this.preset);
}

abstract class ActivePresetEvent {}

class SetActivePreset extends ActivePresetEvent {
  final Preset preset;

  SetActivePreset(this.preset);
}

class ClearActivePreset extends ActivePresetEvent {}

//TODO error handling
class ActivePresetBloc extends Bloc<ActivePresetEvent, ActivePresetState> {
  final SettingsBloc settingsBloc;

  SetPreset _setPreset = SetPreset();

  ActivePresetBloc({this.settingsBloc});

  @override
  ActivePresetState get initialState => ActivePresetState(null);

  void _handleSetPreset(Preset preset) {
    _setPreset.setSimple(
      settingsBloc.state.getUrl(),
      preset,
    );
  }

  @override
  Stream<ActivePresetState> mapEventToState(ActivePresetEvent event) async* {
    if (event is SetActivePreset) {
      _handleSetPreset(event.preset);
      yield ActivePresetState(event.preset);
    } else if (event is ClearActivePreset) {
      yield ActivePresetState(null);
    }
  }
}
