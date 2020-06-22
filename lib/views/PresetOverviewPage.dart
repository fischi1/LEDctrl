import 'package:fischi/api/Toggle.dart';
import 'package:fischi/components/GradientBreakpointBackground.dart';
import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/domain/ColorBreakpoint.dart';
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

  Widget _buildListItem(BuildContext context, bool active) {
    return Container(
      width: double.infinity,
      height: 75,
      margin: EdgeInsets.only(bottom: 2, top: 7.5, left: 7.5, right: 7.5),
      child: FlatButton(
        onPressed: () {
          print("onTap button");
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.zero,
        child: Ink(
          decoration: BoxDecoration(
            gradient: GradientBreakpointBackground.buildGradient(
              [
                ColorBreakpoint(
                  color: HSVColor.fromColor(Colors.orange),
                  position: 0.1,
                ),
                ColorBreakpoint(
                  color: HSVColor.fromColor(Colors.purple),
                  position: 0.9,
                )
              ],
//              begin: Alignment.bottomLeft,
//              end: Alignment.topRight,
              begin: const Alignment(-0.2, -1),
              end: const Alignment(1, 0.2),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            border: active
                ? Border.all(width: 4, color: Colors.white)
                : Border.all(width: 4, color: Color.fromRGBO(0, 0, 0, 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 20),
              Icon(
                Icons.web_asset,
                size: 40,
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Preset #1"),
                  SizedBox(height: 3),
                  Text(
                    "Color",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                  ),
                ],
              ),
              Spacer(),
              PopupMenuButton<String>(
                onSelected: (value) {
                  print(value);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: "rename",
                      child: Text(
                        "Rename",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: "delete",
                      child: Text(
                        "Delete",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
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
      extendBody: true,
      extendBodyBehindAppBar: true,
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
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(
        child: ListView(
          children: <Widget>[
            _buildListItem(context, false),
            _buildListItem(context, false),
            _buildListItem(context, true),
            _buildListItem(context, false),
            _buildListItem(context, false),
            _buildListItem(context, false),
            _buildListItem(context, true),
            _buildListItem(context, false),
            _buildListItem(context, false),
            _buildListItem(context, false),
            _buildListItem(context, false),
          ],
        ),
      ),
    );
  }
}
