import 'package:fischi/util/SnackbarHelper.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        SnackBarHelper.error(context, "Hello World!");
      },
    );
  }
}
