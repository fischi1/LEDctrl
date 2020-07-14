import 'package:fischi/blocs/ActivePresetBloc.dart';
import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/blocs/UserMessagesToSnackbarListener.dart';
import 'package:fischi/components/PresetListItem.dart';
import 'package:fischi/components/SettingsButton.dart';
import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:fischi/domain/preset/Presets.dart';
import 'package:fischi/util/PresetTypeToPreset.dart';
import 'package:fischi/views/ChoosePresetType.dart';
import 'package:fischi/views/ImagePresetDetailPage.dart';
import 'package:fischi/views/RandomPresetPage.dart';
import 'package:fischi/views/SimplePresetPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PresetOverviewPage extends StatefulWidget {
  @override
  _PresetOverviewPageState createState() => _PresetOverviewPageState();
}

class _PresetOverviewPageState extends State<PresetOverviewPage> {
  void _handleNewPresetChosen(PresetType presetType) {
    var newPreset = presetTypeToPreset(context, presetType);
    context.bloc<PresetBloc>().add(AddPreset(newPreset));
    _handleSendUserToPreset(newPreset);
  }

  void _handleSendUserToPreset(Preset preset) {
    switch (preset.presetType) {
      case PresetType.simple:
        _navigate(SimplePresetPage(presetId: preset.id));
        break;
      case PresetType.randomSimple:
        _navigate(RandomPresetPage(presetId: preset.id));
        break;
      case PresetType.image:
        _navigate(ImagePresetDetailPage(presetId: preset.id));
        break;
      default:
        print("no page for $preset.presetType");
    }
  }

  void _navigate(Widget widget) async {
    final idPresetBefore = context.bloc<ActivePresetBloc>().state.preset?.id;
    await Navigator.of(context).push(
      new CupertinoPageRoute(builder: (context) => widget),
    );
    if (idPresetBefore == null) return;
    final presetBefore = context.bloc<PresetBloc>().state[idPresetBefore];
    context.bloc<ActivePresetBloc>().add(SetActivePreset(presetBefore));
  }

  void _handleRename(String newName, Preset preset) {
    final newPreset = preset.copy();
    newPreset.name = newName;
    context.bloc<PresetBloc>().add(UpdatePreset(newPreset));
  }

  List<Widget> _buildPresetList(
    Map<String, Preset> presets,
    String activePresetId,
  ) {
    return presets.keys
        .map<Widget>(
          (id) => PresetListItem(
            key: ValueKey(id),
            active: activePresetId == id,
            title: presets[id].name,
            subtitle: presetTypeNames[presets[id].presetType],
            icon: presetTypeIcons[presets[id].presetType],
            onSelect: () {
              context
                  .bloc<ActivePresetBloc>()
                  .add(SetActivePreset(presets[id]));
            },
            onEdit: () => _handleSendUserToPreset(presets[id]),
            onDelete: () =>
                context.bloc<PresetBloc>().add(RemovePreset(presets[id].id)),
            onRename: (newName) => _handleRename(newName, presets[id]),
            gradient: presets[id].buildGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        )
        .toList()
          ..add(SizedBox(height: 7.5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentGradientAppBar(title: "LEDctrl"),
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
            _handleNewPresetChosen(presetType);
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
        child: BlocBuilder<PresetBloc, Map<String, Preset>>(
          builder: (context, allPresets) {
            if (allPresets.isEmpty) {
              return Center(
                child: Text("You haven't created any presets yet"),
              );
            }
            return BlocBuilder<ActivePresetBloc, ActivePresetState>(
              builder: (context, activePresetState) => ListView(
                children: _buildPresetList(
                  allPresets,
                  activePresetState.preset?.id,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
