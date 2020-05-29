import 'package:fischi/TransparentGradientAppBar.dart';
import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:fischi/slider/ColorSlider.dart';
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ColorBreakpoint> breakpoints;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TransparentGradientAppBar(),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: buildGradientBackground(),
          child: Align(
            alignment: Alignment(0.8, 0),
            //slider start
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
        ));
  }
}
