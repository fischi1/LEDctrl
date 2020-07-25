import 'package:fischi/blocs/ActivePresetBloc.dart';
import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/components/HsvColorEditor.dart';
import 'package:fischi/components/LedAppPage.dart';
import 'package:fischi/components/SlidingBrightnessPanel.dart';
import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/domain/preset/StroboscopePreset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StroboscopePresetPage extends StatefulWidget {
  final String presetId;

  const StroboscopePresetPage({Key key, this.presetId}) : super(key: key);

  @override
  _StroboscopePresetPageState createState() => _StroboscopePresetPageState();
}

class _StroboscopePresetPageState extends State<StroboscopePresetPage> {
  final _formatter = NumberFormat("0.000");

  @override
  void initState() {
    final preset =
        context.bloc<PresetBloc>().state[widget.presetId] as StroboscopePreset;
    context.bloc<ActivePresetBloc>().add(SetActivePreset(preset));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresetBloc, Map<String, Preset>>(
      builder: (context, state) {
        final preset = state[widget.presetId] as StroboscopePreset;
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

        void handleToggleDurationChanged(double newToggleDuration) {
          final copiedPreset = preset.copy() as StroboscopePreset;
          copiedPreset.toggleDuration = newToggleDuration;
          updatePreset(copiedPreset);
        }

        void handleColorChanged(HSVColor newColor) {
          final copiedPreset = preset.copy() as StroboscopePreset;
          copiedPreset.color = newColor;
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
                        child: Text("Toggle duration"),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Slider(
                              activeColor: Theme.of(context).buttonColor,
                              inactiveColor:
                                  Theme.of(context).buttonColor.withAlpha(125),
                              value: preset.toggleDuration,
                              onChanged: handleToggleDurationChanged,
                              min: 0.025,
                              max: 0.35,
                            ),
                          ),
                          Container(
                            width: 35,
                            child: Center(
                              child: Text(
                                "${_formatter.format(preset.toggleDuration)}",
                                softWrap: false,
                              ),
                            ),
                          ),
                          SizedBox(width: padding)
                        ],
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: HsvColorEditor(
                          value: preset.color,
                          onChange: handleColorChanged,
                        ),
                      ),
                      SizedBox(height: 15)
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
