import 'package:bloc/bloc.dart';
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
                new Future.delayed(
                  const Duration(milliseconds: 500),
                  () {
                    context.bloc<OnOffBloc>().add(OnOffEvent.setOn);
                  },
                );
                break;
              case OnOffState.togglingOff:
                new Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
                    context.bloc<OnOffBloc>().add(OnOffEvent.setOff);
                  },
                );
                break;
              default:
            }
          },
          child: child,
        );
}
