import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:flutter/material.dart';

import 'HandleContainer.dart';

class ColorSlider extends StatefulWidget {
  final List<ColorBreakpoint> breakpoints;
  final ValueChanged<List<ColorBreakpoint>> onChange;

  ColorSlider({this.breakpoints, this.onChange});

  @override
  _ColorSliderState createState() => _ColorSliderState();
}

class _ColorSliderState extends State<ColorSlider> {
  double value1 = 0.5;
  double value2 = 0.1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(139, 0, 0, 0),
      width: 50,
      height: double.infinity,
      child: Align(
        alignment: Alignment.topCenter,
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: <Widget>[
              HandleContainer(
                value: value1,
                onChange: (newValue) {
                  setState(() {
                    value1 = value1;
                  });
                },
                height: constraints.biggest.height,
                color: Colors.orange,
              ),
              HandleContainer(
                value: value2,
                onChange: (newValue) {
                  setState(() {
                    value2 = value2;
                  });
                },
                height: constraints.biggest.height,
                color: Colors.purple,
              ),
            ],
          );
        }),
      ),
    );
  }
}
