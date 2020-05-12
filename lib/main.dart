import 'package:fischi/SliderGestureExample.dart';
import 'package:fischi/TransparentGradientAppBar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyGestureApp());

//https://medium.com/@aneesshameed/flutter-draggable-widget-daf81d232f36

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        secondaryHeaderColor: Colors.white,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Offset _offset = Offset(60, 300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TransparentGradientAppBar(),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.orange,
        body: Padding(
          padding: EdgeInsets.fromLTRB(_offset.dx, _offset.dy, 0, 0),
          child: Draggable(
            axis: Axis.vertical,
            child: Container(
              color: Colors.blue,
              width: 90,
              height: 90,
            ),
            feedback: Container(
              color: Colors.green,
              width: 90,
              height: 90,
            ),
            childWhenDragging: Container(),
            onDragEnd: (drag) {
              setState(() {
                _offset = Offset(drag.offset.dx, drag.offset.dy);
              });
            },
          ),
        ));
  }
}
