import 'package:fischi/api/Toggle.dart';
import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/domain/PresetType.dart';
import 'package:fischi/views/ChoosePresetType.dart';
import 'package:fischi/views/SimplePresetPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PresetOverviewPage extends StatefulWidget {
  @override
  _PresetOverviewPageState createState() => _PresetOverviewPageState();
}

class _PresetOverviewPageState extends State<PresetOverviewPage> {
  bool onOffToggle = true;

  void _navigate(BuildContext context, Widget widget) {
    Navigator.of(context).push(
      new CupertinoPageRoute(builder: (context) => widget),
    );
  }

  void _handleNewPresetChosen(BuildContext context, PresetType presetType) {
    switch (presetType) {
      case PresetType.simple:
        _navigate(context, SimplePresetPage());
        break;
      default:
        print("no page for $presetType");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentGradientAppBar(
        title: "All Presets",
        toggleValue: onOffToggle,
        onToggleChange: (val) {
          Toggle.toggleOnOff(val);
          setState(() {
            onOffToggle = val;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          PresetType presetType = await Navigator.of(context).push(
            new CupertinoPageRoute<PresetType>(
              builder: (context) => ChoosePresetType(),
              fullscreenDialog: true,
              maintainState: true,
            ),
          );

          if (presetType != null) {
            _handleNewPresetChosen(context, presetType);
          }
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryIconTheme.color,
        ),
        backgroundColor: Theme.of(context).buttonColor,
      ),
      body: Center(
        child: Container(),
      ),
    );
  }
}
