import 'dart:math';

import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  final key = GlobalKey<ScaffoldState>();

  AnimationController _successAnimController;
  AnimationController _failureAnimController;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyApp.scaffoldKey = key;

    return Scaffold(
      appBar: TransparentGradientAppBar(
        title: "Settings",
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      extendBody: true,
      key: key,
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'IP address or hostname',
              ),
            ),
            SizedBox(height: 15),
            TextField(
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
              child: RaisedButton(
                child: Text("Test connection"),
                onPressed: () {
                  if (Random().nextDouble() > 0.5) {
                    _successAnimController.forward();
                    new Future<void>.delayed(Duration(milliseconds: 2000))
                        .then((val) {
                      _successAnimController.reverse();
                    });
                  } else {
                    _failureAnimController.forward();
                    new Future<void>.delayed(Duration(milliseconds: 2000))
                        .then((val) {
                      _failureAnimController.reverse();
                    });
                  }
                },
              ),
            ),
            //TODO change to cards maybe
            SizeTransition(
              sizeFactor: _successAnimController,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
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
            SizeTransition(
              sizeFactor: _failureAnimController,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
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
          ],
        ),
      ),
    );
  }
}
