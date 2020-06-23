import 'package:fischi/components/PresetListItem.dart';
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

  Widget _buildListItem(BuildContext context, bool active, int index) {
    return PresetListItem(
      active: active,
      title: "Preset #$index",
      subtitle: "Color",
      onSelect: () {},
      onDelete: () {},
      onRename: () {},
      colorBreakpoints: const [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentGradientAppBar(title: "All Presets"),
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
            _buildListItem(context, false, 1),
            _buildListItem(context, false, 2),
            _buildListItem(context, true, 3),
            _buildListItem(context, false, 4),
            _buildListItem(context, false, 5),
            _buildListItem(context, false, 6),
            _buildListItem(context, true, 7),
            _buildListItem(context, false, 8),
            _buildListItem(context, false, 9),
            _buildListItem(context, false, 10),
            _buildListItem(context, false, 11),
            _buildListItem(context, false, 12),
            _buildListItem(context, false, 13),
            _buildListItem(context, false, 14),
            _buildListItem(context, true, 15),
            _buildListItem(context, false, 16),
            _buildListItem(context, false, 17),
            SizedBox(height: 7.5)
          ],
        ),
      ),
    );
  }
}
