import 'dart:ui';

import 'package:fischi/blocs/PresetBloc.dart';
import 'package:fischi/components/BrightnessPanel.dart';
import 'package:fischi/components/SourceImageDisplay.dart';
import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:fischi/domain/preset/Presets.dart';
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
  ImagePreset _imagePreset;

  @override
  void initState() {
    _imagePreset = context.bloc<PresetBloc>().state[widget.presetId];
    if (_imagePreset.sourceImage == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _getSourceImage();
      });
    }
    super.initState();
  }

  void _getSourceImage() async {
    final result = await Navigator.of(context).push(
      new CupertinoPageRoute(
        builder: (context) => ChooseImagePage(),
        fullscreenDialog: true,
      ),
    );

    if (result != null) {
      setState(() {
        _imagePreset.sourceImage = result;
      });
    } else {
      if (_imagePreset.sourceImage == null) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = TransparentGradientAppBar(
      title: _imagePreset.name,
      onBackButtonPressed: () {
        Navigator.of(context).pop();
      },
    );
    return Scaffold(
      appBar: appBar,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _imagePreset.sourceImage != null
                ? AssetImage(_imagePreset.sourceImage.imagePath)
                : MemoryImage(kTransparentImage),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: ClipRect(
            child: Stack(
              children: <Widget>[
                SafeArea(
                  child: _imagePreset.sourceImage != null
                      ? SourceImageDisplay(
                          sourceImage: _imagePreset.sourceImage,
                          onChangeImage: _getSourceImage,
                        )
                      : Container(),
                ),
                BrightnessPanel(
                  value: 0.6,
                  onChange: (newVal) {},
                  screenHeight: MediaQuery.of(context).size.width,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
