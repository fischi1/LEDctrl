import 'package:flutter/material.dart';

class LedHandle extends StatelessWidget {
  final Color color;
  final Offset offset;
  final double radius;

  LedHandle({this.color, this.offset, this.radius = 25});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(color: color, offset: offset, radius: radius),
    );
  }
}

class MyPainter extends CustomPainter {
  Color color = Colors.white;
  Offset offset = Offset.zero;
  double radius = 0;

  MyPainter({this.color, this.offset, this.radius});

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
