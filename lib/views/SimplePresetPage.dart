import 'package:fischi/api/SetPreset.dart';
import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/blocs/SettingsBloc.dart';
import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/components/slider/ColorBreakpointListEditor.dart';
import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:fischi/domain/preset/Presets.dart';
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
  SetPreset setPreset = SetPreset();

  void _handleBreakpointChange(List<ColorBreakpoint> newBreakpoints) {
    setPreset.setSimple(
      context.bloc<SettingsBloc>().state.getUrl(),
      newBreakpoints,
    );
    // ignore: close_sinks
    final presetBloc = context.bloc<PresetBloc>();
    final copiedPreset =
        ColorBreakpointPreset.copy(presetBloc.state[widget.presetId]);
    copiedPreset.breakpoints = newBreakpoints..sort((a, b) => a.compare(b));
    presetBloc.add(UpdatePreset(copiedPreset));
    setPreset.setSimple(
      context.bloc<SettingsBloc>().state.getUrl(),
      copiedPreset.breakpoints,
    );
  }

  HSVColor currentColor = HSVColor.fromColor(Colors.green);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentGradientAppBar(
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<PresetBloc, Map<String, Preset>>(
        builder: (context, state) {
          var preset = state[widget.presetId];
          if (preset == null || !(preset is ColorBreakpointPreset))
            return Container();

          final colorBreakpointPreset = preset as ColorBreakpointPreset;

          return ColorBreakpointListEditor(
            breakpoints: colorBreakpointPreset.breakpoints,
            onChange: _handleBreakpointChange,
            gradient: colorBreakpointPreset.buildGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
            ),
          );
        },
      ),
    );
  }
}
