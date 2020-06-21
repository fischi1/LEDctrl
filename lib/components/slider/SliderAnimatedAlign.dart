import 'package:flutter/material.dart';

class SliderAnimatedAlign extends StatefulWidget {
  final Widget child;
  final bool right;
  final Function onEnd;

  SliderAnimatedAlign({this.child, this.right = true, this.onEnd});

  @override
  _SliderAnimatedAlignState createState() => _SliderAnimatedAlignState();
}

class _SliderAnimatedAlignState extends State<SliderAnimatedAlign> {
  final double rightValue = 0.8;
  final double leftValue = -0.8;

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: Alignment(
        widget.right ? rightValue : leftValue,
        0,
      ),
      onEnd: () {
        if (widget.onEnd != null) {
          widget.onEnd();
        }
      },
      duration: const Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut,
      child: widget.child,
    );
  }
}
