import 'package:fischi/TransparentGradientAppBar.dart';
import 'package:fischi/slider/ColorSlider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
          //slider start
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: ColorSlider(),
          ),
        ));
  }
}
