import 'package:fischi/TransparentGradientAppBar.dart';
import 'package:flutter/material.dart';

import 'LedHandle.dart';

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
            child: LayoutBuilder(
              builder: (context, constraints) {
//                print(constraints.biggest.height);
                //599.2727272727273
                return Container(
                  color: Color.fromARGB(139, 0, 0, 0),
                  width: 50,
                  height: constraints.biggest.height,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        30,
                        0,
                        0,
                      ),
                      child: HandleContainer(),
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}

class HandleContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        height: 50,
        width: 50,
        color: Colors.white,
        child: LedHandle(
          offset: Offset(25, 25),
          color: Colors.green,
        ),
      ),
    );
  }
}
