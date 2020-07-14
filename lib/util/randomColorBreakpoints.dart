import 'dart:math';

import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:flutter/cupertino.dart';

final _random = Random();

List<ColorBreakpoint> randomColorBreakpoints() {
  final numberBreakpoints = _random.nextInt(6) + 1;

  final List<ColorBreakpoint> ret = [];

  for (var i = 0; i < numberBreakpoints; i++) {
    ret.add(ColorBreakpoint(
      position: _random.nextDouble(),
      color: HSVColor.fromColor(Color.fromARGB(
        255,
        (255 * _random.nextDouble()).floor(),
        (255 * _random.nextDouble()).floor(),
        (255 * _random.nextDouble()).floor(),
      )),
    ));
  }

  ret.sort((a, b) => a.compare(b));

  return ret;
}
