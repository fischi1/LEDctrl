import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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

  void _handleColorChange(HSVColor newColor) {
    var newBreakPoint = ColorBreakpoint.copy(colorBreakpoint);
    newBreakPoint.color = newColor;
    onChange(newBreakPoint);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        0,
        95,
        0,
        15,
      ),
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
                  mainAxisAlignment: MainAxisAlignment.end,
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
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ColorPickerSlider(
                    TrackType.hue,
                    colorBreakpoint.color,
                    _handleColorChange,
                    displayThumbColor: true,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ColorPickerSlider(
                    TrackType.saturation,
                    colorBreakpoint.color,
                    _handleColorChange,
                    displayThumbColor: true,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ColorPickerSlider(
                    TrackType.value,
                    colorBreakpoint.color,
                    _handleColorChange,
                    displayThumbColor: true,
                  ),
                ),
                ColorPickerLabel(
                  colorBreakpoint.color,
                  editable: false,
                  enableAlpha: false,
                  onColorChanged: _handleColorChange,
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
