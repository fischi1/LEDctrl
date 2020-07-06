import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ShadowIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const ShadowIcon(this.icon, {Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: <Widget>[
          Container(
            child: Icon(
              icon,
              size: size,
              color: const Color.fromARGB(125, 0, 0, 0),
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              child: Icon(icon, size: size),
            ),
          )
        ],
      ),
    );
  }
}
