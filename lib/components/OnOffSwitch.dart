import 'package:fischi/blocs/OnOffBloc.dart';
import 'package:fischi/components/EmoteSwitch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnOffSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ValueChanged<bool> handleChange = (val) {
      context
          .bloc<OnOffBloc>()
          .add(val ? OnOffEvent.toggleOn : OnOffEvent.toggleOff);
    };

    return BlocBuilder<OnOffBloc, OnOffState>(
      builder: (BuildContext context, OnOffState state) {
        bool toggleVal;
        bool disabled = false;

        if (state == OnOffState.on ||
            state == OnOffState.togglingOff ||
            state == OnOffState.initial ||
            state == OnOffState.progressInitial)
          toggleVal = true;
        else
          toggleVal = false;

        if (state != OnOffState.on && state != OnOffState.off) {
          disabled = true;
        }

        return EmoteSwitch(
          value: toggleVal,
          onChanged: disabled ? null : handleChange,
        );
      },
    );
  }
}
