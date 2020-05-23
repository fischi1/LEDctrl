import 'package:fischi/TransparentGradientAppBar.dart';
import 'package:flutter/material.dart';

//https://stackoverflow.com/questions/51216747/constraining-draggable-area

//changed to allow custom sizes
//width pixel 3a 392.7

class SliderGestureCustomSizeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: TransparentGradientAppBar(),
        body: BoxTest(),
      ),
    );
  }
}

class BoxTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints.biggest);
        return UnconstrainedBox(
          child: new Container(
            color: Colors.green,
            width: constraints.biggest.width,
            height: constraints.biggest.height,
          ),
        );
      },
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
      widget.valueChanged(valueListener.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        print(MediaQuery.of(context).size);
        final handle = GestureDetector(
          onHorizontalDragUpdate: (details) {
            double newVal = valueListener.value + details.delta.dx;
            if (newVal < 0) newVal = 0;
            if (newVal > MediaQuery.of(context).size.width - (50 + 92.8))
              newVal = MediaQuery.of(context).size.width - (50 + 92.8);
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
