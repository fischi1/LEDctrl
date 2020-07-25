import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

const Color _kThumbBorderColor = Color(0x0A000000);
final _kThumbGradient = RadialGradient(
  center: const Alignment(0, 0),
  colors: [
    Colors.white,
    Color.fromARGB(255, 250, 255, 80),
  ],
  stops: [0, 1],
);
final _kShineGradient = RadialGradient(
  center: const Alignment(0, 0),
  colors: [
    Color.fromARGB(94, 245, 245, 255),
    Color.fromARGB(0, 250, 255, 80),
  ],
  stops: [0, 0.6],
);
final _kThumbOffColor = Colors.grey;
final _kLetterZColor = Color.fromARGB(255, 128, 179, 255);

const List<BoxShadow> _kSwitchBoxShadows = <BoxShadow>[
  BoxShadow(
    color: Color(0x26000000),
    offset: Offset(0, 3),
    blurRadius: 8.0,
  ),
  BoxShadow(
    color: Color(0x0F000000),
    offset: Offset(0, 3),
    blurRadius: 1.0,
  ),
];

const List<BoxShadow> _kSliderBoxShadows = <BoxShadow>[
  BoxShadow(
    color: Color(0x26000000),
    offset: Offset(0, 3),
    blurRadius: 8.0,
  ),
  BoxShadow(
    color: Color(0x29000000),
    offset: Offset(0, 1),
    blurRadius: 1.0,
  ),
  BoxShadow(
    color: Color(0x1A000000),
    offset: Offset(0, 3),
    blurRadius: 1.0,
  ),
];

/// Based on [CupertinoThumbPainter]
class EmoteSwitchThumbPainter {
  /// Creates an object that paints an iOS-style slider thumb.
  const EmoteSwitchThumbPainter(
      {this.color = CupertinoColors.white, this.shadows = _kSliderBoxShadows})
      : assert(shadows != null);

  /// Creates an object that paints an iOS-style switch thumb.
  const EmoteSwitchThumbPainter.switchThumb({
    Color color = CupertinoColors.white,
    List<BoxShadow> shadows = _kSwitchBoxShadows,
  }) : this(color: color, shadows: shadows);

  /// The color of the interior of the thumb.
  final Color color;

  /// The list of [BoxShadow] to paint below the thumb.
  ///
  /// Must not be null.
  final List<BoxShadow> shadows;

  /// Half the default diameter of the thumb.
  static const double radius = 17.0;

  /// The default amount the thumb should be extended horizontally when pressed.
  static const double extension = 7.0;

  /// Paints the thumb onto the given canvas in the given rectangle.
  ///
  /// Consider using [radius] and [extension] when deciding how large a
  /// rectangle to use for the thumb.
  void paint(Canvas canvas, Rect rect, bool toggleValue) {
    final RRect rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(rect.shortestSide / 2.0),
    );

    for (final BoxShadow shadow in shadows)
      canvas.drawRRect(rrect.shift(shadow.offset), shadow.toPaint());

    canvas.drawRRect(
      rrect.inflate(0.5),
      Paint()..color = _kThumbBorderColor,
    );

    if (toggleValue)
      paintOnEmote(canvas, rrect);
    else
      paintOffEmote(canvas, rrect);
  }

  void paintOnEmote(Canvas canvas, RRect rrect) {
    final center = rrect.center;

    final emoteDetailPaint = Paint();
    final thumbPaint = Paint()
      ..shader = _kThumbGradient.createShader(
        Rect.fromCircle(
          center: center,
          radius: radius * 3,
        ),
      );

    final shinePaint = Paint()
      ..shader = _kShineGradient.createShader(
        Rect.fromCircle(
          center: center,
          radius: radius * 3,
        ),
      );

    //shine
    canvas.drawCircle(center, radius * 5, shinePaint);

    //body on
    canvas.drawRRect(rrect, thumbPaint);

    //right eye open
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx + radius * 0.47, center.dy),
        height: radius * 0.464,
        width: radius * 0.318,
      ),
      emoteDetailPaint,
    );

    //left eye open
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx - radius * 0.47, center.dy),
        height: radius * 0.464,
        width: radius * 0.318,
      ),
      emoteDetailPaint,
    );

    //mouth open
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + radius * 0.368),
        height: radius * 0.5,
        width: radius * 0.5,
      ),
      0,
      pi,
      false,
      emoteDetailPaint,
    );
  }

  void paintOffEmote(Canvas canvas, RRect rrect) {
    final center = rrect.center;

    final emoteDetailOffPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    //body on
    canvas.drawRRect(rrect, Paint()..color = _kThumbOffColor);

    //right eye closed
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(center.dx + radius * 0.47, center.dy),
        height: radius * 0.464,
        width: radius * 0.42,
      ),
      0,
      pi,
      false,
      emoteDetailOffPaint,
    );

    //left eye closed
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(center.dx - radius * 0.47, center.dy),
        height: radius * 0.464,
        width: radius * 0.42,
      ),
      0,
      pi,
      false,
      emoteDetailOffPaint,
    );

    //mouth open
    canvas.drawCircle(
      Offset(center.dx, center.dy + radius * 0.547),
      radius * 0.226,
      Paint(),
    );

    TextSpan span = TextSpan(
      style: TextStyle(
          color: _kLetterZColor,
          fontSize: radius * 0.65,
          fontWeight: FontWeight.bold),
      text: "Z",
    );
    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(
      canvas,
      Offset(center.dx + radius * 0.1, center.dy - radius * 0.8),
    );
    tp.paint(
      canvas,
      Offset(center.dx + radius * 0.6, center.dy - radius * 1.2),
    );
    tp.paint(
      canvas,
      Offset(center.dx + radius * 1.1, center.dy - radius * 0.95),
    );
  }
}
