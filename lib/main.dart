import 'package:fischi/views/PresetOverviewPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LED Action',
      theme: ThemeData(
        brightness: Brightness.dark,
        secondaryHeaderColor: Colors.white,
      ),
      home: PresetOverviewPage(),
    );
  }
}
