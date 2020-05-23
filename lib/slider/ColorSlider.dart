import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:flutter/material.dart';

class ColorSlider extends StatelessWidget {
  final List<ColorBreakpoint> breakpoints;
  final ValueChanged<List<ColorBreakpoint>> onChange;

  ColorSlider({this.breakpoints, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
