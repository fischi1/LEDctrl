import 'package:fischi/blocs/ActivePresetBloc.dart';
import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/components/BrightnessPanel.dart';
import 'package:fischi/components/HsvColorEditor.dart';
import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/domain/preset/PingPongPreset.dart';
import 'package:fischi/domain/preset/Preset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PingPongPresetPage extends StatefulWidget {
  final String presetId;

  const PingPongPresetPage({Key key, this.presetId}) : super(key: key);

  @override
  _PingPongPresetPageState createState() => _PingPongPresetPageState();
}

class _PingPongPresetPageState extends State<PingPongPresetPage> {
  final _formatter = NumberFormat("0.00");

  @override
  void initState() {
    final preset =
        context.bloc<PresetBloc>().state[widget.presetId] as PingPongPreset;
    context.bloc<ActivePresetBloc>().add(SetActivePreset(preset));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresetBloc, Map<String, Preset>>(
      builder: (context, state) {
        final preset = state[widget.presetId] as PingPongPreset;
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

        void handleRadiusChanged(double newRadius) {
          final copiedPreset = preset.copy() as PingPongPreset;
          copiedPreset.radius = newRadius.floor();
          updatePreset(copiedPreset);
        }

        void handleTransitionTimeChanged(double newTransitionTime) {
          final copiedPreset = preset.copy() as PingPongPreset;
          copiedPreset.transitionTime = newTransitionTime;
          updatePreset(copiedPreset);
        }

        void handleColorChanged(HSVColor newColor) {
          final copiedPreset = preset.copy() as PingPongPreset;
          copiedPreset.color = newColor;
          updatePreset(copiedPreset);
        }

        return Scaffold(
          appBar: TransparentGradientAppBar(
            onBackButtonPressed: () => Navigator.pop(context),
            title: preset.name,
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: <Widget>[
              Container(
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
                          child: Text("Radius"),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Slider(
                                value: preset.radius + 0.0,
                                onChanged: handleRadiusChanged,
                                min: 5,
                                max: 50,
                              ),
                            ),
                            Container(
                              width: 35,
                              child: Center(child: Text("${preset.radius}")),
                            ),
                            SizedBox(width: padding)
                          ],
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.only(left: padding),
                          child: Text("Transition time"),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Slider(
                                value: preset.transitionTime,
                                onChanged: handleTransitionTimeChanged,
                                min: 0.02,
                                max: 25,
                              ),
                            ),
                            Container(
                              width: 35,
                              child: Center(
                                child: Text(
                                  "${_formatter.format(preset.transitionTime)}",
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
