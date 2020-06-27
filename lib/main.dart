import 'package:fischi/blocs/OnOffBloc.dart';
import 'package:fischi/blocs/SettingsBloc.dart';
import 'package:fischi/views/PresetOverviewPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnOffBloc(),
        ),
        BlocProvider(
          create: (context) => SettingsBloc(),
        ),
      ],
      child: OnOffListener(
        child: MaterialApp(
          title: 'LED Action',
          theme: ThemeData(
              brightness: Brightness.dark,
              secondaryHeaderColor: Colors.white,
              buttonColor: Colors.teal,
              accentColor: Colors.tealAccent,
              errorColor: Colors.redAccent),
          home: PresetOverviewPage(),
        ),
      ),
    );
  }
}
