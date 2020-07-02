import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/blocs/UserMessagesToSnackbarListener.dart';
import 'package:fischi/components/PresetListItem.dart';
import 'package:fischi/components/SettingsButton.dart';
import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:fischi/domain/preset/Presets.dart';
import 'package:fischi/util/PresetTypeToPreset.dart';
import 'package:fischi/views/ChoosePresetType.dart';
import 'package:fischi/views/SimplePresetPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    var newPreset = presetTypeToPreset(context, presetType);
    context.bloc<PresetBloc>().add(AddPreset(newPreset));
    switch (presetType) {
      case PresetType.simple:
        _navigate(context, SimplePresetPage());
        break;
      default:
        print("no page for $presetType");
    }
  }

  List<Widget> _buildPresetList(List<Preset> presets) {
    return presets
        .map<Widget>(
          (preset) => PresetListItem(
            key: ValueKey(preset.id),
            active: false,
            title: preset.name,
            subtitle: presetTypeNames[preset.presetType],
            icon: presetTypeIcons[preset.presetType],
            onSelect: () {},
            onEdit: () {},
            onDelete: () {},
            onRename: () {},
            gradient: preset.buildGradient(
              begin: const Alignment(-0.2, -1),
              end: const Alignment(1, 0.2),
            ),
          ),
        )
        .toList()
          ..add(SizedBox(height: 7.5));
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
            SettingsButton(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: UserMessagesToSnackbarListener(
        child: Center(
          child: BlocBuilder<PresetBloc, List<Preset>>(
            builder: (context, state) {
              return ListView(
                children: _buildPresetList(state),
              );
            },
          ),
        ),
      ),
    );
  }
}
