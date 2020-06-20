import 'package:flutter/material.dart';

import 'LedHandle.dart';

class HandleContainer extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChange;
  final double height;
  final Color color;
  final Function onSelect;

  HandleContainer({
    this.value,
    @required this.onChange,
    @required this.height,
    this.color = Colors.white,
    @required this.onSelect,
    Key key,
  }) : super(key: key);

  @override
  _HandleContainerState createState() => _HandleContainerState();
}

class _HandleContainerState extends State<HandleContainer> {
  ValueNotifier<double> positionListener;
  double maxHeight = 0;

  @override
  void initState() {
    maxHeight = widget.height - 50;
    positionListener = ValueNotifier(widget.value);
    positionListener.addListener(notifyParent);
    super.initState();
  }

  void notifyParent() {
    if (widget.onChange != null) {
      widget.onChange(positionListener.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        positionListener.value * maxHeight,
        0,
        0,
      ),
      child: GestureDetector(
        onTapDown: (tapDetails) {},
        onTapUp: (tapDetails) {
          widget.onSelect();
        },
        onVerticalDragUpdate: (details) {
          double newVal = positionListener.value * maxHeight + details.delta.dy;
          if (newVal < 0) newVal = 0;
          if (newVal > maxHeight) newVal = maxHeight;
          positionListener.value = newVal / maxHeight;
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
