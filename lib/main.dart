import 'package:fischi/blocs/OnOffBloc.dart';
import 'package:fischi/views/PresetOverviewPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnOffBloc(),
      child: OnOffListener(
        child: MaterialApp(
          title: 'LED Action',
          theme: ThemeData(
            brightness: Brightness.dark,
            secondaryHeaderColor: Colors.white,
            buttonColor: Colors.teal,
            accentColor: Colors.tealAccent,
          ),
          home: PresetOverviewPage(),
        ),
      ),
    );
  }
}
