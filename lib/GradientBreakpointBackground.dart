import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:flutter/material.dart';

class GradientBreakpointBackground {
  static BoxDecoration buildGradientBackground(
      List<ColorBreakpoint> breakpoints) {
    var sortedBreakpoints = List.of(breakpoints);
    sortedBreakpoints.sort((a, b) => a.position.compareTo(b.position));

    if (breakpoints.isEmpty) {
      return BoxDecoration(color: const Color.fromARGB(255, 25, 25, 25));
    }

    return BoxDecoration(
      color: Colors.green,
      gradient: LinearGradient(
        colors: sortedBreakpoints.map((bp) => bp.getEffectiveColor()).toList(),
        stops: sortedBreakpoints.map((bp) => bp.position).toList(),
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }
}
