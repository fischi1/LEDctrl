import 'package:fischi/components/slider/ColorBreakpointEditor.dart';
import 'package:fischi/components/slider/ColorSlider.dart';
import 'package:fischi/components/slider/SliderAnimatedAlign.dart';
import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:flutter/material.dart';

class ColorBreakpointListEditor extends StatefulWidget {
  final List<ColorBreakpoint> breakpoints;
  final ValueChanged<List<ColorBreakpoint>> onChange;
  final Gradient gradient;

  const ColorBreakpointListEditor({
    Key key,
    this.breakpoints,
    this.onChange,
    this.gradient,
  }) : super(key: key);

  @override
  _ColorBreakpointListEditorState createState() =>
      _ColorBreakpointListEditorState();
}

class _ColorBreakpointListEditorState extends State<ColorBreakpointListEditor> {
  String selectedBreakpointId;

  Widget _buildBreakpointEditor() {
    if (selectedBreakpointId == null) return Container();

    return Padding(
      padding: const EdgeInsets.fromLTRB(110, 0, 15, 0),
      child: ColorBreakpointEditor(
        colorBreakpoint: widget.breakpoints[widget.breakpoints
            .indexWhere((cb) => cb.id == selectedBreakpointId)],
        onChange: (changedBreakpoint) {
          var newList = List.of(widget.breakpoints);
          newList[newList.indexWhere((cb) => cb.id == changedBreakpoint.id)] =
              changedBreakpoint;
          widget.onChange(newList);
        },
        onSubmit: () {
          setState(() {
            selectedBreakpointId = null;
          });
        },
        onDelete: () {
          var newList = List.of(widget.breakpoints);
          newList.removeWhere((cb) => cb.id == selectedBreakpointId);
          widget.onChange(newList);
          selectedBreakpointId = null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: widget.gradient),
      child: Stack(
        children: <Widget>[
          _buildBreakpointEditor(),
          SliderAnimatedAlign(
            right: selectedBreakpointId == null,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 95, 0, 55),
              child: ColorSlider(
                breakpoints: widget.breakpoints,
                onChange: widget.onChange,
                onSelectBreakPoint: (breakpoint) {
                  setState(() {
                    selectedBreakpointId = breakpoint.id;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
