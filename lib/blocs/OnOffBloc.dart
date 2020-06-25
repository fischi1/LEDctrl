import 'package:bloc/bloc.dart';
import 'package:fischi/api/Toggle.dart';
import 'package:fischi/util/SnackbarHelper.dart';
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
  @override
  OnOffState get initialState => OnOffState.initial;

  @override
  Stream<OnOffState> mapEventToState(OnOffEvent event) async* {
    switch (event) {
      case OnOffEvent.getInitial:
        yield OnOffState.progressInitial;
        break;
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
              case OnOffState.progressInitial:
                handleInitial(context);
                break;
              case OnOffState.togglingOn:
                handleToggle(context, true);
                break;
              case OnOffState.togglingOff:
                handleToggle(context, false);
                break;
              default:
            }
          },
          child: Builder(builder: (context) {
            final state = context.bloc<OnOffBloc>().state;

            if (state == OnOffState.initial) {
              context.bloc<OnOffBloc>().add(OnOffEvent.getInitial);
            }

            return child;
          }),
        );

  static void handleInitial(BuildContext context) {
    print("initial");
    Toggle.getToggle().then(
      (value) => context
          .bloc<OnOffBloc>()
          .add(value ? OnOffEvent.setOn : OnOffEvent.setOff),
    );
  }

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
        SnackBarHelper.error(context, "Couldn't toggle leds on/off");
        context
            .bloc<OnOffBloc>()
            .add(value ? OnOffEvent.setOff : OnOffEvent.setOn);
      },
    );
  }
}
