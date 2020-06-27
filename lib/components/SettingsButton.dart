import 'package:fischi/views/SettingsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.of(context)
            .push(new CupertinoPageRoute(builder: (context) => SettingsPage()));
      },
    );
  }
}
