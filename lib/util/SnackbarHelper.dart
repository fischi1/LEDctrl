import 'package:fischi/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static void error(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: Theme.of(context).primaryTextTheme.body1,
      ),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
    );
    MyApp.scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
