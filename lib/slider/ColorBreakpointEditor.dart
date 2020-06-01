import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:flutter/material.dart';

enum ColorChannel { red, green, blue }

class ColorBreakpointEditor extends StatelessWidget {
  final ColorBreakpoint colorBreakpoint;
  final ValueChanged<ColorBreakpoint> onChange;
  final Function onDelete;
  final Function onSubmit;

  ColorBreakpointEditor({
    @required this.colorBreakpoint,
    @required this.onChange,
    @required this.onDelete,
    @required this.onSubmit,
  });

  void handleColorValueChange(int newValue, ColorChannel channel) {
    var newBreakPoint = ColorBreakpoint.copy(colorBreakpoint);
    newBreakPoint.color = Color.fromARGB(
      255,
      channel == ColorChannel.red ? newValue : newBreakPoint.color.red,
      channel == ColorChannel.green ? newValue : newBreakPoint.color.green,
      channel == ColorChannel.blue ? newValue : newBreakPoint.color.blue,
    );
    onChange(newBreakPoint);
  }

  void handleBrightnessMultiplerChange(double newValue) {
    var newBreakPoint = ColorBreakpoint.copy(colorBreakpoint);
    newBreakPoint.brightnessMultiplier = newValue;
    onChange(newBreakPoint);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 120, 0, 40),
      child: Container(
        height: double.infinity,
        child: UnconstrainedBox(
          constrainedAxis: Axis.horizontal,
          alignment: Alignment(0, colorBreakpoint.position * 2 - 1),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(139, 0, 0, 0),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: onSubmit,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: onDelete,
                    )
                  ],
                ),
                Slider(
                  activeColor: Colors.red,
                  max: 255,
                  value: colorBreakpoint.color.red + 0.0,
                  onChanged: (val) {
                    handleColorValueChange(val.floor(), ColorChannel.red);
                  },
                ),
                Slider(
                  activeColor: Colors.green,
                  max: 255,
                  value: colorBreakpoint.color.green + 0.0,
                  onChanged: (val) {
                    handleColorValueChange(val.floor(), ColorChannel.green);
                  },
                ),
                Slider(
                  activeColor: Colors.blue,
                  max: 255,
                  value: colorBreakpoint.color.blue + 0.0,
                  onChanged: (val) {
                    handleColorValueChange(val.floor(), ColorChannel.blue);
                  },
                ),
                Slider(
                  activeColor: Colors.white,
                  value: colorBreakpoint.brightnessMultiplier,
                  onChanged: handleBrightnessMultiplerChange,
                ),
                Text(
                  "${colorBreakpoint.color.red}, ${colorBreakpoint.color.green}, ${colorBreakpoint.color.blue}, ${(colorBreakpoint.brightnessMultiplier * 100).roundToDouble() / 100}",
                ),
                SizedBox(
                  height: 12,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
