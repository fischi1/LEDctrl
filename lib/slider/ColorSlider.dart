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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(139, 0, 0, 0),
      width: 60,
      height: double.infinity,
      child: Align(
        alignment: Alignment.topCenter,
        child: LayoutBuilder(builder: (context, constraints) {
          return Builder(
            builder: (context) {
              List<Widget> builtBreakpoints =
                  widget.breakpoints.map((breakPoint) {
                return HandleContainer(
                  value: breakPoint.value,
                  color: breakPoint.color,
                  height: constraints.biggest.height,
                  onChange: (newValue) {
                    var newBreakpoints =
                        widget.breakpoints.map((elem) => elem).toList();
                    newBreakpoints[newBreakpoints.indexOf(breakPoint)].value =
                        newValue;
                    widget.onChange(newBreakpoints);
                  },
                );
              }).toList(growable: false);

              return Stack(
                children: builtBreakpoints,
              );
            },
          );
        }),
      ),
    );
  }
}
