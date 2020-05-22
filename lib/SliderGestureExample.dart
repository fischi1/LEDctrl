import 'package:flutter/material.dart';

//https://stackoverflow.com/questions/51216747/constraining-draggable-area

class MyGestureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Slider(
              valueChanged: (val) {
                print(val);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Slider extends StatefulWidget {
  final ValueChanged<double> valueChanged;

  Slider({this.valueChanged});

  @override
  SliderState createState() {
    return new SliderState();
  }
}

class SliderState extends State<Slider> {
  ValueNotifier<double> valueListener = ValueNotifier(.0);

  @override
  void initState() {
    valueListener.addListener(notifyParent);
    super.initState();
  }

  void notifyParent() {
    if (widget.valueChanged != null) {
      widget.valueChanged(valueListener.value / 310.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final handle = GestureDetector(
          onHorizontalDragUpdate: (details) {
            double newVal = valueListener.value + details.delta.dx;
            if (newVal < 0) newVal = 0;
            if (newVal > MediaQuery.of(context).size.width - 50)
              newVal = MediaQuery.of(context).size.width - 50;
            valueListener.value = newVal;
          },
          child: FlutterLogo(size: 50.0),
        );

        return AnimatedBuilder(
          animation: valueListener,
          builder: (context, child) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                valueListener.value,
                0,
                0,
                0,
              ),
              child: child,
            );
          },
          child: handle,
        );
      },
    );
  }
}
