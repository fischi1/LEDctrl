import 'package:fischi/blocs/ActivePresetBloc.dart';
import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/components/BrightnessPanel.dart';
import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/domain/preset/ColorBreakpointPreset.dart';
import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/util/randomColorBreakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomPresetPage extends StatefulWidget {
  final String presetId;

  const RandomPresetPage({Key key, this.presetId}) : super(key: key);

  @override
  _RandomPresetPageState createState() => _RandomPresetPageState();
}

class _RandomPresetPageState extends State<RandomPresetPage> {
  @override
  void initState() {
    final preset = context.bloc<PresetBloc>().state[widget.presetId];
    context.bloc<ActivePresetBloc>().add(SetActivePreset(preset));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresetBloc, Map<String, Preset>>(
      builder: (context, state) {
        final preset = state[widget.presetId];

        void handleBrightnessChange(double newVal) {
          final copiedPreset = preset.copy();
          copiedPreset.brightnessMultiplier = newVal;
          context.bloc<PresetBloc>().add(UpdatePreset(copiedPreset));
          context.bloc<ActivePresetBloc>().add(SetActivePreset(copiedPreset));
        }

        void handleShuffleButton() {
          final copiedPreset = preset.copy() as ColorBreakpointPreset;
          copiedPreset.breakpoints = randomColorBreakpoints();
          context.bloc<PresetBloc>().add(UpdatePreset(copiedPreset));
          context.bloc<ActivePresetBloc>().add(SetActivePreset(copiedPreset));
        }

        return Scaffold(
          appBar: TransparentGradientAppBar(
            onBackButtonPressed: () => Navigator.pop(context),
            title: preset.name,
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: handleShuffleButton,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: preset.buildGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "TAP TO SHUFFLE",
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: const Color.fromARGB(125, 0, 0, 0),
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              BrightnessPanel(
                value: preset.brightnessMultiplier,
                onChange: handleBrightnessChange,
                screenHeight: MediaQuery.of(context).size.width,
              )
            ],
          ),
        );
      },
    );
  }
}
