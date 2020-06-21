import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/domain/PresetType.dart';
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
            leading: Icon(Icons.web_asset),
            title: Text('Color'),
            subtitle: Text("Create a preset out of one or more colors"),
            onTap: () => _handleSelection(context, PresetType.simple),
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text('Image'),
            subtitle: Text("Choose a mood from a selection of images"),
            onTap: () => _handleSelection(context, PresetType.image),
          ),
          ExpansionTile(
            leading: Icon(Icons.broken_image),
            title: Text('Effect'),
            subtitle: Text("Multiple effects to choose from"),
            children: <Widget>[
              ListTile(
                contentPadding: subListTileInset,
                title: Text('Ping Pong'),
                onTap: () =>
                    _handleSelection(context, PresetType.effectPingPong),
              ),
              ListTile(
                contentPadding: subListTileInset,
                title: Text('Stroboscope'),
                onTap: () =>
                    _handleSelection(context, PresetType.effectStroboscope),
              ),
              ListTile(
                contentPadding: subListTileInset,
                title: Text('Rainbow'),
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
