import 'package:fischi/TransparentGradientAppBar.dart';
import 'package:flutter/material.dart';

import 'LedHandle.dart';

void main() => runApp(MyApp());

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TransparentGradientAppBar(),
        backgroundColor: Colors.orange,
        body: Align(
          alignment: Alignment(0.8, 0),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            color: Color.fromARGB(139, 0, 0, 0),
            width: 50,
            height: double.infinity,
            child: Align(
              alignment: Alignment(0, -0.25),
              child: UnconstrainedBox(
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.white,
                  child: LedHandle(
                    offset: Offset(25, 25),
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
