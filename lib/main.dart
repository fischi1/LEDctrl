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
  bool sliderRight = false;

  @override
  void initState() {
    super.initState();
    breakpoints = List();
    breakpoints.add(ColorBreakpoint(
      color: Colors.orange,
      value: 0.1,
    ));
    breakpoints.add(ColorBreakpoint(
      color: Colors.purple,
      value: 0.5,
    ));
  }

  BoxDecoration buildGradientBackground() {
    var sortedBreakpoints = List.of(breakpoints);
    sortedBreakpoints.sort((a, b) => a.value.compareTo(b.value));

    return BoxDecoration(
      gradient: LinearGradient(
        colors: sortedBreakpoints.map((bp) => bp.color).toList(),
        stops: sortedBreakpoints.map((bp) => bp.value).toList(),
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  Widget buildBreakpointEditor() {
    if (sliderRight) return Container();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        130,
        0,
        20,
        0,
      ),
      child: ColorBreakpointEditor(
        colorBreakpoint: breakpoints[0],
        onChange: (changedBreakpoint) {
          var newList = List.of(breakpoints);
          newList[0] = changedBreakpoint;
          setState(() {
            breakpoints = newList;
          });
        },
        onDelete: () {
          print("deleting (${breakpoints[0]})");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TransparentGradientAppBar(
          toggleValue: sliderRight,
          onToggleChange: (val) {
            setState(() {
              sliderRight = val;
            });
          },
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: buildGradientBackground(),
          child: Stack(
            children: <Widget>[
              SliderAnimatedAlign(
                right: sliderRight,
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
                  ),
                ),
              ),
              buildBreakpointEditor()
            ],
          ),
        ));
  }
}
