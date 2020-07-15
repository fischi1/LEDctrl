import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HsvColorEditor extends StatelessWidget {
  final HSVColor value;
  final ValueChanged<HSVColor> onChange;

  const HsvColorEditor({Key key, this.value, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40,
          child: ColorPickerSlider(
            TrackType.hue,
            value,
            onChange,
            displayThumbColor: true,
          ),
        ),
        SizedBox(
          height: 40,
          child: ColorPickerSlider(
            TrackType.saturation,
            value,
            onChange,
            displayThumbColor: true,
          ),
        ),
        SizedBox(
          height: 40,
          child: ColorPickerSlider(
            TrackType.value,
            value,
            onChange,
            displayThumbColor: true,
          ),
        ),
        ColorPickerLabel(
          value,
          editable: false,
          enableAlpha: false,
        ),
      ],
    );
  }
}
