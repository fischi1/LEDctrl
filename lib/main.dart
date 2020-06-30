import 'package:fischi/blocs/OnOffBloc.dart';
import 'package:fischi/blocs/SettingsBloc.dart';
import 'package:fischi/views/PresetOverviewPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = await HydratedBlocDelegate.build(
    storageDirectory: await getApplicationSupportDirectory(),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SettingsBloc settingsBloc = SettingsBloc();

  @override
  void dispose() {
    settingsBloc.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => settingsBloc,
        ),
        BlocProvider(
          create: (context) =>
              OnOffBloc(settingsBloc: settingsBloc)..add(OnOffEvent.getInitial),
        ),
      ],
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
    );
  }
}
