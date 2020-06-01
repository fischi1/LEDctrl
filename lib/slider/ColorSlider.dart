import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:flutter/material.dart';

import 'HandleContainer.dart';

class ColorSlider extends StatelessWidget {
  final List<ColorBreakpoint> breakpoints;
  final ValueChanged<List<ColorBreakpoint>> onChange;
  final ValueChanged<ColorBreakpoint> onSelectBreakPoint;

  ColorSlider({this.breakpoints, this.onChange, this.onSelectBreakPoint});

  List<Widget> buildBreakPointHandles(
      BuildContext context, BoxConstraints constraints) {
    return breakpoints.map((breakPoint) {
      return HandleContainer(
        key: Key(breakPoint.id),
        value: breakPoint.position,
        color: breakPoint.getEffectiveColor(),
        height: constraints.biggest.height,
        onChange: (newValue) {
          var newBreakpoints = breakpoints.map((elem) => elem).toList();
          newBreakpoints[newBreakpoints.indexOf(breakPoint)].position =
              newValue;
          onChange(newBreakpoints);
        },
        onSelect: () {
          onSelectBreakPoint(breakPoint);
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

    var newList = List.of(breakpoints);
    newList.add(ColorBreakpoint(
      color: Color.fromRGBO(255, 255, 255, 1),
      position: actualRelativePos,
    ));
    onChange(newList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(139, 0, 0, 0),
        borderRadius: BorderRadius.circular(50),
      ),
      width: 60,
      padding: EdgeInsets.all(5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTapUp: (tapDetails) {
              handleAddHandle(
                  tapDetails.localPosition.dy, constraints.maxHeight);
            },
            child: Container(
              decoration: BoxDecoration(),
              child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: buildBreakPointHandles(context, constraints),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
