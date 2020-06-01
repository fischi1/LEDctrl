import 'package:fischi/GradientBreakpointBackground.dart';
import 'package:fischi/TransparentGradientAppBar.dart';
import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:fischi/slider/ColorBreakpointEditor.dart';
import 'package:fischi/slider/ColorSlider.dart';
import 'package:fischi/slider/SliderAnimatedAlign.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        secondaryHeaderColor: Colors.white,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ColorBreakpoint> breakpoints;
  String selectedBreakpointId;
  bool onOffToggle = true;

  @override
  void initState() {
    super.initState();
    breakpoints = List();
    breakpoints.add(ColorBreakpoint(
      color: Colors.orange,
      position: 0.1,
    ));
    breakpoints.add(ColorBreakpoint(
      color: Colors.purple,
      position: 0.5,
    ));
  }

  Widget buildBreakpointEditor() {
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
          setState(() {
            breakpoints = newList;
          });
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
            breakpoints = newList;
            selectedBreakpointId = null;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TransparentGradientAppBar(
          toggleValue: onOffToggle,
          onToggleChange: (val) {
            setState(() {
              onOffToggle = val;
            });
          },
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration:
              GradientBreakpointBackground.buildGradientBackground(breakpoints),
          child: Stack(
            children: <Widget>[
              SliderAnimatedAlign(
                right: selectedBreakpointId == null,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    120,
                    0,
                    40,
                  ),
                  child: ColorSlider(
                    breakpoints: breakpoints,
                    onChange: (newBreakpoints) {
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
              buildBreakpointEditor()
            ],
          ),
        ));
  }
}
