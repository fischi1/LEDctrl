import 'package:flutter/material.dart';

class BrightnessPanel extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChange;
  final double screenHeight;

  const BrightnessPanel({
    Key key,
    this.screenHeight,
    this.onChange,
    this.value,
  }) : super(key: key);

  @override
  _BrightnessPanelState createState() => _BrightnessPanelState();
}

class _BrightnessPanelState extends State<BrightnessPanel>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  bool _opened = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 27 / widget.screenHeight),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.easeInToLinear,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleToggle() {
    setState(() {
      _opened = !_opened;
    });
    if (_opened)
      _controller.forward();
    else
      _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(139, 0, 0, 0),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: GestureDetector(
              onTap: _handleToggle,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(Icons.brightness_6),
              ),
            ),
          ),
          Container(
            height: 50,
            color: const Color.fromARGB(139, 0, 0, 0),
            width: double.infinity,
            child: Slider(
              activeColor: Theme.of(context).buttonColor,
              inactiveColor: Theme.of(context).buttonColor.withAlpha(125),
              value: widget.value,
              onChanged: widget.onChange,
            ),
          )
        ],
      ),
    );
  }
}
