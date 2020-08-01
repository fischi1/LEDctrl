import 'package:fischi/blocs/ActivePresetBloc.dart';
import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/blocs/UserMessagesToSnackbarListener.dart';
import 'package:fischi/components/LedAppPage.dart';
import 'package:fischi/components/PresetListItem.dart';
import 'package:fischi/components/SettingsButton.dart';
import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:fischi/util/PresetTypeToPreset.dart';
import 'package:fischi/views/ChoosePresetType.dart';
import 'package:fischi/views/ImagePresetDetailPage.dart';
import 'package:fischi/views/PingPongPresetPage.dart';
import 'package:fischi/views/RainbowPresetPage.dart';
import 'package:fischi/views/RandomPresetPage.dart';
import 'package:fischi/views/SimplePresetPage.dart';
import 'package:fischi/views/StroboscopePresetPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PresetOverviewPage extends StatefulWidget {
  @override
  _PresetOverviewPageState createState() => _PresetOverviewPageState();
}

class _PresetOverviewPageState extends State<PresetOverviewPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

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
      case PresetType.effectPingPong:
        _navigate(PingPongPresetPage(presetId: preset.id));
        break;
      case PresetType.effectStroboscope:
        _navigate(StroboscopePresetPage(presetId: preset.id));
        break;
      case PresetType.effectRainbow:
        _navigate(RainbowPresetPage(presetId: preset.id));
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
    final presetBefore =
        context.bloc<PresetBloc>().state.presetMap[idPresetBefore];
    context.bloc<ActivePresetBloc>().add(SetActivePreset(presetBefore));
  }

  void _handleRename(String newName, Preset preset) {
    final newPreset = preset.copy();
    newPreset.name = newName;
    context.bloc<PresetBloc>().add(UpdatePreset(newPreset));
  }

  Widget _buildPresetItem(
      Map<String, Preset> presets, String id, String activePresetId) {
    return PresetListItem(
      key: ValueKey(id),
      active: activePresetId == id,
      title: presets[id].name,
      subtitle: presetTypeNames[presets[id].presetType],
      icon: presetTypeIcons[presets[id].presetType],
      onSelect: () {
        context.bloc<ActivePresetBloc>().add(SetActivePreset(presets[id]));
      },
      onEdit: () => _handleSendUserToPreset(presets[id]),
      onDelete: () {
        final snackBar = SnackBar(
          content: Text(
            "Preset removed",
            style: Theme.of(context).primaryTextTheme.bodyText2,
          ),
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'UNDO',
            textColor: Theme.of(context).buttonTheme.colorScheme.secondary,
            onPressed: () => _globalKey.currentContext
                .bloc<PresetBloc>()
                .add(UndoDeletePreset()),
          ),
        );

        Scaffold.of(_globalKey.currentContext).removeCurrentSnackBar();
        Scaffold.of(_globalKey.currentContext).showSnackBar(snackBar);
        _globalKey.currentContext.bloc<PresetBloc>().add(RemovePreset(id));
      },
      onRename: (newName) => _handleRename(newName, presets[id]),
      gradient: presets[id].buildGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LedAppPage(
      title: "LEDctrl",
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
      child: UserMessagesToSnackbarListener(
        key: _globalKey,
        child: BlocBuilder<PresetBloc, PresetBlocState>(
          builder: (context, state) {
            final presetMap = state.presetMap;
            if (presetMap.isEmpty) {
              return Center(
                child: Text("You haven't created any presets yet"),
              );
            }
            final keys = presetMap.keys.toList();
            return BlocBuilder<ActivePresetBloc, ActivePresetState>(
              builder: (context, activePresetState) => ListView.builder(
                itemCount: presetMap.length,
                itemBuilder: (context, index) => _buildPresetItem(
                    presetMap, keys[index], activePresetState?.preset?.id),
              ),
            );
          },
        ),
      ),
    );
  }
}
