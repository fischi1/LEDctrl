import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:flutter/material.dart';

import 'HandleContainer.dart';

class ColorSlider extends StatelessWidget {
  final List<ColorBreakpoint> breakpoints;
  final ValueChanged<List<ColorBreakpoint>> onChange;

  ColorSlider({this.breakpoints, this.onChange});

  List<Widget> buildBreakPointHandles(
      BuildContext context, BoxConstraints constraints) {
    return breakpoints.map((breakPoint) {
      return HandleContainer(
        value: breakPoint.value,
        color: breakPoint.color,
        height: constraints.biggest.height,
        onChange: (newValue) {
          var newBreakpoints = breakpoints.map((elem) => elem).toList();
          newBreakpoints[newBreakpoints.indexOf(breakPoint)].value = newValue;
          onChange(newBreakpoints);
        },
      );
    }).toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(139, 0, 0, 0),
      width: 60,
      height: double.infinity,
      child: Align(
        alignment: Alignment.topCenter,
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: buildBreakPointHandles(context, constraints),
          );
        }),
      ),
    );
  }
}
