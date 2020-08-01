import 'package:fischi/api/Toggle.dart';
import 'package:fischi/blocs/ActivePresetBloc.dart';
import 'package:fischi/blocs/OnOffBloc.dart';
import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/blocs/SettingsBloc.dart';
import 'package:fischi/blocs/UserMessagesToSnackbarListener.dart';
import 'package:fischi/components/LedAppPage.dart';
import 'package:fischi/components/ProgressButton.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:fischi/util/presetTypeToPreset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  bool testInProgress = false;

  AnimationController _successAnimController;
  AnimationController _failureAnimController;

  TextEditingController _addressController;
  TextEditingController _portController;

  @override
  void initState() {
    _successAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    _failureAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );

    _addressController =
        TextEditingController(text: context.bloc<SettingsBloc>().state.address);
    _portController =
        TextEditingController(text: context.bloc<SettingsBloc>().state.port);

    super.initState();
  }

  void _handleAddressChanged(String newVal) {
    context.bloc<SettingsBloc>().add(AddressChanged(newVal));
  }

  void _handlePortChanged(String newVal) {
    context.bloc<SettingsBloc>().add(PortChanged(newVal));
  }

  void _handleTestConnection() {
    setState(() {
      testInProgress = true;
    });
    Toggle(context.bloc<SettingsBloc>().state.getUrl())
        .getToggle()
        .then((value) {
      context
          .bloc<OnOffBloc>()
          .add(value ? OnOffEvent.setOn : OnOffEvent.setOff);
      _handleConnectionTestSuccess();
    }).catchError((error) {
      print(error);
      _handleConnectionTestFail();
    }).whenComplete(() {
      setState(() {
        testInProgress = false;
      });
    });
  }

  void _handleConnectionTestSuccess() {
    _successAnimController.forward();
    _failureAnimController.reverse();
    new Future<void>.delayed(Duration(milliseconds: 3000)).then((val) {
      _successAnimController.reverse();
    });
  }

  void _handleConnectionTestFail() {
    _failureAnimController.forward();
    _successAnimController.reverse();
    new Future<void>.delayed(Duration(milliseconds: 3000)).then((val) {
      _failureAnimController.reverse();
    });
  }

  void _handleResetApp() {
    context.bloc<PresetBloc>().add(ClearAllPresets());
    context.bloc<ActivePresetBloc>().add(ClearActivePreset());
    context.bloc<SettingsBloc>().add(ResetSettings());
    Navigator.of(context).pop();
  }

  void _handleAddDebugData() {
    for (int i = 0; i < 100; i++) {
      final preset = presetTypeToPreset(context, PresetType.randomSimple);
      context.bloc<PresetBloc>().add(AddPreset(preset));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return LedAppPage(
      title: "Settings",
      navigatorPopOnBack: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      child: UserMessagesToSnackbarListener(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: <Widget>[
              TextField(
                controller: _addressController,
                onChanged: _handleAddressChanged,
                decoration: const InputDecoration(
                  labelText: 'IP address or hostname',
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _portController,
                onChanged: _handlePortChanged,
                decoration: const InputDecoration(
                  labelText: 'Server port',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                ],
              ),
              SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                child: ProgressButton(
                  text: Text("TEST CONNECTION"),
                  inProgress: testInProgress,
                  onPressed: _handleTestConnection,
                ),
              ),
              SizedBox(height: 10),
              SizeTransition(
                sizeFactor: _successAnimController,
                child: Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                    leading: Icon(
                      Icons.thumb_up,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text(
                      "All good, connection established!",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ),
              SizeTransition(
                sizeFactor: _failureAnimController,
                child: Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                    leading: Icon(
                      Icons.warning,
                      color: Theme.of(context).errorColor,
                    ),
                    title: Text(
                      "Could't not connect to server. Check address and port.",
                      style: TextStyle(color: Theme.of(context).errorColor),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Divider(),
              Container(
                alignment: Alignment.centerLeft,
                child: RaisedButton(
                  child: Text("RESET APP"),
                  onPressed: _handleResetApp,
                ),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: RaisedButton(
                  child: Text("ADD DEBUG DATA"),
                  onPressed: _handleAddDebugData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
