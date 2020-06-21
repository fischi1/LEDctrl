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

  Widget _buildListItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      width: double.infinity,
      height: 75,
      margin: EdgeInsets.only(bottom: 7.5, top: 7.5, left: 7.5, right: 7.5),
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
          IconButton(
            icon: Icon(
              Icons.more_vert,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
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
            _buildListItem(context),
            _buildListItem(context),
            _buildListItem(context),
            _buildListItem(context),
            _buildListItem(context),
            _buildListItem(context),
            _buildListItem(context),
            _buildListItem(context),
            _buildListItem(context),
            _buildListItem(context),
            _buildListItem(context),
          ],
        ),
      ),
    );
  }
}
