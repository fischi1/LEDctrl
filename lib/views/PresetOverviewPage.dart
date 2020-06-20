import 'package:fischi/api/Toggle.dart';
import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/views/SimplePresetPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PresetOverviewPage extends StatefulWidget {
  @override
  _PresetOverviewPageState createState() => _PresetOverviewPageState();
}

class _PresetOverviewPageState extends State<PresetOverviewPage> {
  bool onOffToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentGradientAppBar(
        toggleValue: onOffToggle,
        onToggleChange: (val) {
          Toggle.toggleOnOff(val);
          setState(() {
            onOffToggle = val;
          });
        },
      ),
      body: Container(
        color: Colors.green,
        width: 300,
        height: 500,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                new CupertinoPageRoute(
                    builder: (context) => new SimplePresetPage()),
              );
            },
            child: Text("simple preset"),
          ),
        ),
      ),
    );
  }
}
