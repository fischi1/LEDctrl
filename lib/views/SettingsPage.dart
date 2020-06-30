import 'package:fischi/api/Toggle.dart';
import 'package:fischi/blocs/OnOffBloc.dart';
import 'package:fischi/blocs/SettingsBloc.dart';
import 'package:fischi/blocs/UserMessagesToSnackbarListener.dart';
import 'package:fischi/components/ProgressButton.dart';
import 'package:fischi/components/TransparentGradientAppBar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentGradientAppBar(
        title: "Settings",
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: UserMessagesToSnackbarListener(
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
                  text: Text("Test connection".toUpperCase()),
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
            ],
          ),
        ),
      ),
    );
  }
}
