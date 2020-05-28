import 'dart:math';

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

  void handleAddHandle(double pos, double maxHeight) {
    double actualRelativePos;

    if (pos < 25)
      actualRelativePos = 0;
    else if (pos > maxHeight - 25)
      actualRelativePos = 1;
    else
      actualRelativePos = pos / maxHeight;

    var random = Random();

    var newList = List.of(breakpoints);
    newList.add(ColorBreakpoint(
      color: Color.fromRGBO(
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
        1,
      ),
      value: actualRelativePos,
    ));
    onChange(newList);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapUp: (tapDetails) {
            handleAddHandle(tapDetails.localPosition.dy, constraints.maxHeight);
          },
          child: Container(
            color: Color.fromARGB(139, 0, 0, 0),
            width: 60,
            height: double.infinity,
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: buildBreakPointHandles(context, constraints),
              ),
            ),
          ),
        );
      },
    );
  }
}
