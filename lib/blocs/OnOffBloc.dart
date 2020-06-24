import 'package:bloc/bloc.dart';
import 'package:fischi/api/Toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum OnOffEvent {
  toggleOn,
  toggleOff,
  setOn,
  setOff,
}

enum OnOffState {
  on,
  off,
  togglingOn,
  togglingOff,
}

class OnOffBloc extends Bloc<OnOffEvent, OnOffState> {
  @override
  OnOffState get initialState => OnOffState.on;

  @override
  Stream<OnOffState> mapEventToState(OnOffEvent event) async* {
    switch (event) {
      case OnOffEvent.toggleOn:
        yield OnOffState.togglingOn;
        break;
      case OnOffEvent.toggleOff:
        yield OnOffState.togglingOff;
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

class OnOffListener extends BlocListener<OnOffBloc, OnOffState> {
  OnOffListener({Widget child})
      : super(
          listener: (context, state) {
            print(state);
            switch (state) {
              case OnOffState.togglingOn:
                handleToggle(context, true);
                break;
              case OnOffState.togglingOff:
                handleToggle(context, false);
                break;
              default:
            }
          },
          child: child,
        );

  static void handleToggle(BuildContext context, bool value) {
    Toggle.toggleOnOff(value)
        .then(
      (response) => context
          .bloc<OnOffBloc>()
          .add(value ? OnOffEvent.setOn : OnOffEvent.setOff),
    )
        .catchError(
      (error) {
        print(error);
        context
            .bloc<OnOffBloc>()
            .add(value ? OnOffEvent.setOff : OnOffEvent.setOn);
      },
    );
  }
}
