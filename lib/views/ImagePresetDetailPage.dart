import 'dart:ui';

import 'package:fischi/blocs/ActivePresetBloc.dart';
import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/components/BrightnessPanel.dart';
import 'package:fischi/components/SourceImageDisplay.dart';
import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/domain/preset/ImagePreset.dart';
import 'package:fischi/domain/preset/Preset.dart';
import 'package:fischi/views/ChooseImagePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

class ImagePresetDetailPage extends StatefulWidget {
  final String presetId;

  const ImagePresetDetailPage({Key key, this.presetId}) : super(key: key);

  @override
  _ImagePresetDetailPageState createState() => _ImagePresetDetailPageState();
}

class _ImagePresetDetailPageState extends State<ImagePresetDetailPage> {
  @override
  void initState() {
    final imagePreset =
        context.bloc<PresetBloc>().state[widget.presetId] as ImagePreset;
    if (imagePreset.sourceImage == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _getSourceImage();
      });
    } else {
      context.bloc<ActivePresetBloc>().add(SetActivePreset(imagePreset));
    }
    super.initState();
  }

  void _getSourceImage() async {
    final imagePreset =
        context.bloc<PresetBloc>().state[widget.presetId] as ImagePreset;

    final result = await Navigator.of(context).push(
      new CupertinoPageRoute(
        builder: (context) => ChooseImagePage(),
        fullscreenDialog: true,
      ),
    );

    if (result != null) {
      final newPreset = imagePreset.copy() as ImagePreset;
      newPreset.sourceImage = result;
      context.bloc<PresetBloc>().add(UpdatePreset(newPreset));
      context.bloc<ActivePresetBloc>().add(SetActivePreset(newPreset));
    } else {
      if (imagePreset.sourceImage == null) {
        Navigator.of(context).pop();
        context.bloc<PresetBloc>().add(RemovePreset(imagePreset.id));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresetBloc, Map<String, Preset>>(
      builder: (context, state) {
        final imagePreset = state[widget.presetId] as ImagePreset;

        if (imagePreset == null) {
          return Container();
        }

        void _handleBrightnessChanged(double newVal) {
          final newPreset = imagePreset.copy();
          newPreset.brightnessMultiplier = newVal;
          context.bloc<ActivePresetBloc>().add(SetActivePreset(newPreset));
          context.bloc<PresetBloc>().add(UpdatePreset(newPreset));
        }

        final appBar = TransparentGradientAppBar(
          title: imagePreset.name,
          onBackButtonPressed: () {
            Navigator.of(context).pop();
          },
        );

        return Scaffold(
          appBar: appBar,
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imagePreset.sourceImage != null
                        ? AssetImage(imagePreset.sourceImage.imagePath)
                        : MemoryImage(kTransparentImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(
                  1 - imagePreset.brightnessMultiplier,
                ),
              ),
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Stack(
                    children: <Widget>[
                      SafeArea(
                        child: imagePreset.sourceImage != null
                            ? SourceImageDisplay(
                                sourceImage: imagePreset.sourceImage,
                                onChangeImage: _getSourceImage,
                              )
                            : Container(),
                      ),
                      BrightnessPanel(
                        value: imagePreset.brightnessMultiplier,
                        onChange: _handleBrightnessChanged,
                        screenHeight: MediaQuery.of(context).size.width,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
