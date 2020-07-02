import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/domain/preset/PresetType.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoosePresetType extends StatelessWidget {
  void _handleSelection(BuildContext context, PresetType presetType) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(presetType);
    }
  }

  void _handleBackBtn(BuildContext context) {
    _handleSelection(context, null);
  }

  @override
  Widget build(BuildContext context) {
    const subListTileInset = const EdgeInsets.only(left: 73);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: LedBackButton(
          onPressed: () => _handleBackBtn(context),
        ),
        title: Text("Choose a preset"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(presetTypeIcons[PresetType.simple]),
            title: Text(presetTypeNames[PresetType.simple]),
            subtitle: Text("Create a preset out of one or more colors"),
            onTap: () => _handleSelection(context, PresetType.simple),
          ),
          ListTile(
            leading: Icon(presetTypeIcons[PresetType.randomSimple]),
            title: Text(presetTypeNames[PresetType.randomSimple]),
            subtitle: Text("Let a random color preset be created for you"),
            onTap: () => _handleSelection(context, PresetType.randomSimple),
          ),
          ListTile(
            leading: Icon(presetTypeIcons[PresetType.image]),
            title: Text(presetTypeNames[PresetType.image]),
            subtitle: Text("Choose a mood from a selection of images"),
            onTap: () => _handleSelection(context, PresetType.image),
          ),
          ExpansionTile(
            leading: Icon(presetTypeIcons[PresetType.effectPingPong]),
            title: Text('Effect'),
            subtitle: Text("Multiple effects to choose from"),
            children: <Widget>[
              ListTile(
                contentPadding: subListTileInset,
                title: Text(presetTypeNames[PresetType.effectPingPong]),
                onTap: () =>
                    _handleSelection(context, PresetType.effectPingPong),
              ),
              ListTile(
                contentPadding: subListTileInset,
                title: Text(presetTypeNames[PresetType.effectStroboscope]),
                onTap: () =>
                    _handleSelection(context, PresetType.effectStroboscope),
              ),
              ListTile(
                contentPadding: subListTileInset,
                title: Text(presetTypeNames[PresetType.effectRainbow]),
                onTap: () =>
                    _handleSelection(context, PresetType.effectRainbow),
              ),
            ],
          )
        ],
      ),
    );
  }
}
