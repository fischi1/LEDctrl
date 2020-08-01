import 'package:fischi/blocs/ActivePresetBloc.dart';
import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/components/LedAppPage.dart';
import 'package:fischi/components/SlidingBrightnessPanel.dart';
import 'package:fischi/components/slider/ColorBreakpointListEditor.dart';
import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:fischi/domain/preset/ColorBreakpointPreset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimplePresetPage extends StatefulWidget {
  final String presetId;

  const SimplePresetPage({
    Key key,
    @required this.presetId,
  }) : super(key: key);

  @override
  _SimplePresetPageState createState() => _SimplePresetPageState();
}

class _SimplePresetPageState extends State<SimplePresetPage> {
  ActivePresetBloc _activePresetBloc;
  PresetBloc _presetBloc;

  @override
  void initState() {
    _activePresetBloc = context.bloc<ActivePresetBloc>();
    _presetBloc = context.bloc<PresetBloc>();
    _activePresetBloc.add(
      SetActivePreset(_presetBloc.state.presetMap[widget.presetId]),
    );
    super.initState();
  }

  void _handleBreakpointChange(List<ColorBreakpoint> newBreakpoints) {
    final copiedPreset = ColorBreakpointPreset.copy(
        _presetBloc.state.presetMap[widget.presetId]);
    copiedPreset.breakpoints = newBreakpoints..sort((a, b) => a.compare(b));
    _presetBloc.add(UpdatePreset(copiedPreset));
    _activePresetBloc.add(SetActivePreset(copiedPreset));
  }

  void _handleBrightnessChange(double newVal) {
    final copiedPreset = _presetBloc.state.presetMap[widget.presetId].copy();
    copiedPreset.brightnessMultiplier = newVal;
    _presetBloc.add(UpdatePreset(copiedPreset));
    _activePresetBloc.add(SetActivePreset(copiedPreset));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresetBloc, PresetBlocState>(
      builder: (context, state) {
        var preset = state.presetMap[widget.presetId];
        if (preset == null || !(preset is ColorBreakpointPreset))
          return Container();

        final colorBreakpointPreset = preset as ColorBreakpointPreset;

        return LedAppPage(
          title: preset.name,
          navigatorPopOnBack: true,
          extendBodyBehindAppBar: true,
          child: SlidingBrightnessPanel(
            value: preset.brightnessMultiplier,
            onChange: _handleBrightnessChange,
            child: ColorBreakpointListEditor(
              breakpoints: colorBreakpointPreset.breakpoints,
              onChange: _handleBreakpointChange,
              gradient: colorBreakpointPreset.buildGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
        );
      },
    );
  }
}
