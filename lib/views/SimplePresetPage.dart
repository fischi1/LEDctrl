import 'package:fischi/api/SetPreset.dart';
import 'package:fischi/blocs/SettingsBloc.dart';
import 'package:fischi/components/GradientBreakpointBackground.dart';
import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/components/slider/ColorBreakpointEditor.dart';
import 'package:fischi/components/slider/ColorSlider.dart';
import 'package:fischi/components/slider/SliderAnimatedAlign.dart';
import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimplePresetPage extends StatefulWidget {
  @override
  _SimplePresetPageState createState() => _SimplePresetPageState();
}

class _SimplePresetPageState extends State<SimplePresetPage> {
  List<ColorBreakpoint> breakpoints;
  String selectedBreakpointId;
  SetPreset setPreset = SetPreset();

  @override
  void initState() {
    super.initState();
    breakpoints = List();
    breakpoints.add(ColorBreakpoint(
      color: HSVColor.fromColor(Colors.orange),
      position: 0.1,
    ));
    breakpoints.add(ColorBreakpoint(
      color: HSVColor.fromColor(Colors.purple),
      position: 0.9,
    ));
  }

  void handleBreakpointChange(List<ColorBreakpoint> newBreakpoints) {
    setPreset.setSimple(
      context.bloc<SettingsBloc>().state.getUrl(),
      newBreakpoints,
    );
    setState(() {
      breakpoints = newBreakpoints;
    });
  }

  Widget _buildBreakpointEditor() {
    if (selectedBreakpointId == null) return Container();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        110,
        0,
        15,
        0,
      ),
      child: ColorBreakpointEditor(
        colorBreakpoint: breakpoints[
            breakpoints.indexWhere((cb) => cb.id == selectedBreakpointId)],
        onChange: (changedBreakpoint) {
          var newList = List.of(breakpoints);
          newList[newList.indexWhere((cb) => cb.id == changedBreakpoint.id)] =
              changedBreakpoint;
          handleBreakpointChange(newList);
        },
        onSubmit: () {
          setState(() {
            selectedBreakpointId = null;
          });
        },
        onDelete: () {
          var newList = List.of(breakpoints);
          newList.removeWhere((cb) => cb.id == selectedBreakpointId);
          setState(() {
            handleBreakpointChange(newList);
            selectedBreakpointId = null;
          });
        },
      ),
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
        body: Container(
          decoration:
              GradientBreakpointBackground.buildGradientBackground(breakpoints),
          child: Stack(
            children: <Widget>[
              _buildBreakpointEditor(),
              SliderAnimatedAlign(
                right: selectedBreakpointId == null,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    95,
                    0,
                    15,
                  ),
                  child: ColorSlider(
                    breakpoints: breakpoints,
                    onChange: (newBreakpoints) {
                      setPreset.setSimple(
                        context.bloc<SettingsBloc>().state.getUrl(),
                        newBreakpoints,
                      );
                      setState(() {
                        breakpoints = newBreakpoints;
                      });
                    },
                    onSelectBreakPoint: (breakpoint) {
                      setState(() {
                        selectedBreakpointId = breakpoint.id;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
