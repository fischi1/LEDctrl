import 'package:flutter/material.dart';

class LedHandle extends StatelessWidget {
  final Color color;
  final Offset offset;

  LedHandle({this.color, this.offset});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(color: color, offset: offset),
    );
  }
}

class MyPainter extends CustomPainter {
  Color color = Colors.white;
  Offset offset = Offset.zero;

  MyPainter({this.color, this.offset});

  final gradient = RadialGradient(
    center: const Alignment(0, 0),
    colors: [
      Colors.transparent,
      Color.fromARGB(50, 40, 40, 40),
    ],
    stops: [0.1, 1],
  );

  @override
  void paint(Canvas canvas, Size size) {
    final radius = 25.0;

    final gradientPaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(
          center: offset,
          radius: radius,
        ),
      );

    final colorPaint = Paint()..color = color;

    canvas.drawCircle(
      offset,
      radius,
      colorPaint,
    );
    canvas.drawCircle(
      offset,
      radius,
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
