import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingBrightnessPanel extends StatelessWidget {
  final Widget child;
  final double value;
  final ValueChanged<double> onChange;

  const SlidingBrightnessPanel({
    Key key,
    this.value,
    this.onChange,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
      backdropEnabled: true,
      backdropOpacity: 0,
      color: const Color.fromARGB(139, 0, 0, 0),
      minHeight: 40,
      maxHeight: 100,
      header: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: Icon(Icons.brightness_6),
      ),
      panel: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Slider(
            activeColor: Theme.of(context).buttonColor,
            inactiveColor: Theme.of(context).buttonColor.withAlpha(125),
            value: value,
            onChanged: onChange,
          ),
        ],
      ),
      body: child,
    );
  }
}
