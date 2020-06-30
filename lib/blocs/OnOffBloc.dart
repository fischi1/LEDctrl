import 'package:bloc/bloc.dart';
import 'package:fischi/api/Toggle.dart';
import 'package:fischi/blocs/SettingsBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum OnOffEvent {
  toggleOn,
  toggleOff,
  setOn,
  setOff,
  getInitial,
}

enum OnOffState {
  on,
  off,
  togglingOn,
  togglingOff,
  initial,
  progressInitial,
}

class OnOffBloc extends Bloc<OnOffEvent, OnOffState> {
  final SettingsBloc settingsBloc;

  OnOffBloc({@required this.settingsBloc});

  @override
  OnOffState get initialState => OnOffState.initial;

  void handleInitial() {
    print("initial");
    Toggle(settingsBloc.state.getUrl())
        .getToggle()
        .then((value) => add(value ? OnOffEvent.setOn : OnOffEvent.setOff))
        .catchError((error) {
      print(error);
      //TODO snackbar
      add(OnOffEvent.setOff);
    });
  }

  void handleToggle(bool value) {
    Toggle(settingsBloc.state.getUrl())
        .toggleOnOff(value)
        .then((response) => add(value ? OnOffEvent.setOn : OnOffEvent.setOff))
        .catchError(
      (error) {
        print(error);
        //TODO snackbar
        add(value ? OnOffEvent.setOff : OnOffEvent.setOn);
      },
    );
  }

  @override
  Stream<OnOffState> mapEventToState(OnOffEvent event) async* {
    switch (event) {
      case OnOffEvent.getInitial:
        yield OnOffState.progressInitial;
        handleInitial();
        break;
      case OnOffEvent.toggleOn:
        yield OnOffState.togglingOn;
        handleToggle(true);
        break;
      case OnOffEvent.toggleOff:
        yield OnOffState.togglingOff;
        handleToggle(false);
        break;
      case OnOffEvent.setOn:
        yield OnOffState.on;
        break;
      case OnOffEvent.setOff:
        yield OnOffState.off;
        break;
    }
  }
}
