import 'package:fischi/blocs/ActivePresetBloc.dart';
import 'package:fischi/blocs/OnOffBloc.dart';
import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/blocs/SettingsBloc.dart';
import 'package:fischi/blocs/UserMessagesBloc.dart';
import 'package:fischi/views/PresetOverviewPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationSupportDirectory(),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SettingsBloc settingsBloc = SettingsBloc();
  final UserMessagesBloc userMessagesBloc = UserMessagesBloc();

  @override
  void dispose() {
    settingsBloc.close();
    userMessagesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => settingsBloc,
        ),
        BlocProvider(
          create: (context) => userMessagesBloc,
        ),
        BlocProvider(
          create: (context) => PresetBloc(),
        ),
        BlocProvider(
          create: (context) => ActivePresetBloc(settingsBloc: settingsBloc),
        ),
        BlocProvider(
          create: (context) => OnOffBloc(
            settingsBloc: settingsBloc,
            userMessagesBloc: userMessagesBloc,
          )..add(OnOffEvent.getInitial),
        ),
      ],
      child: MaterialApp(
        title: 'LEDctrl',
        theme: ThemeData(
          brightness: Brightness.dark,
          secondaryHeaderColor: Colors.white,
          buttonColor: Colors.teal,
          accentColor: Colors.tealAccent,
          errorColor: Colors.redAccent,
        ),
        home: PresetOverviewPage(),
      ),
    );
  }
}
