import 'package:fischi/blocs/ActivePresetBloc.dart';
import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/components/LedAppPage.dart';
import 'package:fischi/components/SlidingBrightnessPanel.dart';
import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/domain/preset/RainbowPreset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RainbowPresetPage extends StatefulWidget {
  final String presetId;

  const RainbowPresetPage({Key key, this.presetId}) : super(key: key);

  @override
  _RainbowPresetPageState createState() => _RainbowPresetPageState();
}

class _RainbowPresetPageState extends State<RainbowPresetPage> {
  @override
  void initState() {
    final preset = context.bloc<PresetBloc>().state.presetMap[widget.presetId];
    context.bloc<ActivePresetBloc>().add(SetActivePreset(preset));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresetBloc, PresetBlocState>(
      builder: (context, state) {
        final preset = state.presetMap[widget.presetId] as RainbowPreset;
        const padding = 23.5;

        void updatePreset(Preset newPreset) {
          context.bloc<PresetBloc>().add(UpdatePreset(newPreset));
          context.bloc<ActivePresetBloc>().add(SetActivePreset(newPreset));
        }

        void handleBrightnessChange(double newVal) {
          final copiedPreset = preset.copy();
          copiedPreset.brightnessMultiplier = newVal;
          updatePreset(copiedPreset);
        }

        void handleWidthChanged(int newWidth) {
          final copiedPreset = preset.copy() as RainbowPreset;
          copiedPreset.width = newWidth;
          updatePreset(copiedPreset);
        }

        void handleLedsPerSecondChanged(int newLedsPerSecond) {
          final copiedPreset = preset.copy() as RainbowPreset;
          copiedPreset.ledsPerSecond = newLedsPerSecond;
          updatePreset(copiedPreset);
        }

        return LedAppPage(
          title: preset.name,
          navigatorPopOnBack: true,
          extendBodyBehindAppBar: true,
          child: SlidingBrightnessPanel(
            value: preset.brightnessMultiplier,
            onChange: handleBrightnessChange,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                gradient: preset.buildGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(139, 0, 0, 0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: padding),
                        child: Text("Width"),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Slider(
                              activeColor: Theme.of(context).buttonColor,
                              inactiveColor:
                                  Theme.of(context).buttonColor.withAlpha(125),
                              value: preset.width + 0.0,
                              onChanged: (newVal) =>
                                  handleWidthChanged(newVal.floor()),
                              min: 1,
                              max: 100,
                              divisions: 100,
                            ),
                          ),
                          Container(
                            width: 35,
                            child: Center(
                              child: Text("${preset.width}", softWrap: false),
                            ),
                          ),
                          SizedBox(width: padding)
                        ],
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(left: padding),
                        child: Text("Speed (leds per second)"),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Slider(
                              activeColor: Theme.of(context).buttonColor,
                              inactiveColor:
                                  Theme.of(context).buttonColor.withAlpha(125),
                              value: preset.ledsPerSecond + 0.0,
                              onChanged: (newVal) =>
                                  handleLedsPerSecondChanged(newVal.floor()),
                              min: 1,
                              max: 100,
                              divisions: 100,
                            ),
                          ),
                          Container(
                            width: 35,
                            child: Center(
                              child: Text("${preset.ledsPerSecond}",
                                  softWrap: false),
                            ),
                          ),
                          SizedBox(width: padding)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
