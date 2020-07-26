import 'dart:math';

const _minThreshold = -0.2;

double normalizedBrightnessTransform(double val) {
  final mapped = (val - _minThreshold) / (1 - _minThreshold);

  final ret = pow(mapped, 3);

//  print("######################");
//  print("old:    $val");
//  print("mapped: $mapped");
//  print("new:    $ret");

  return ret;
}
