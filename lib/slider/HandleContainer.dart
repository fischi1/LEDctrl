import 'package:flutter/material.dart';

import 'LedHandle.dart';

class HandleContainer extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChange;
  final double height;
  final Color color;

  HandleContainer({
    this.value,
    this.onChange,
    @required this.height,
    this.color = Colors.white,
  });

  @override
  _HandleContainerState createState() => _HandleContainerState();
}

class _HandleContainerState extends State<HandleContainer> {
  ValueNotifier<double> valueListener;
  double maxHeight = 0;

  @override
  void initState() {
    maxHeight = widget.height - 50;
    valueListener = ValueNotifier(widget.value);
    valueListener.addListener(notifyParent);
    super.initState();
  }

  void notifyParent() {
    if (widget.onChange != null) {
      widget.onChange(valueListener.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        valueListener.value * maxHeight,
        0,
        0,
      ),
      child: GestureDetector(
        onTapUp: (tapDetails) {},
        onTapDown: (tapDetails) {},
        onVerticalDragUpdate: (details) {
          double newVal = valueListener.value * maxHeight + details.delta.dy;
          if (newVal < 0) newVal = 0;
          if (newVal > maxHeight) newVal = maxHeight;
          valueListener.value = newVal / maxHeight;
        },
        child: UnconstrainedBox(
          child: Container(
            height: 50,
            width: 50,
            child: LedHandle(
              offset: Offset(25, 25),
              color: widget.color,
            ),
          ),
        ),
      ),
    );
  }
}
