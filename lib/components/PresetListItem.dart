import 'dart:math';

import 'package:fischi/components/GradientBreakpointBackground.dart';
import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:flutter/material.dart';

class PresetListItem extends StatelessWidget {
  final bool active;
  final Function onSelect;
  final List<ColorBreakpoint> colorBreakpoints;
  final Function onRename;
  final Function onDelete;
  final String title;
  final String subtitle;

  PresetListItem({
    this.active,
    this.onSelect,
    this.colorBreakpoints = const [],
    this.onRename,
    this.onDelete,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75,
      margin: EdgeInsets.only(bottom: 2, top: 7.5, left: 7.5, right: 7.5),
      child: FlatButton(
        onPressed: onSelect,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.zero,
        child: Ink(
          decoration: BoxDecoration(
            gradient: GradientBreakpointBackground.buildGradient(
              [
                ColorBreakpoint(
                  color: HSVColor.fromColor(Color.fromRGBO(
                    (Random().nextDouble() * 255).floor(),
                    (Random().nextDouble() * 255).floor(),
                    (Random().nextDouble() * 255).floor(),
                    1,
                  )),
                  position: Random().nextDouble() / 2,
                ),
                ColorBreakpoint(
                  color: HSVColor.fromColor(Color.fromRGBO(
                    (Random().nextDouble() * 255).floor(),
                    (Random().nextDouble() * 255).floor(),
                    (Random().nextDouble() * 255).floor(),
                    1,
                  )),
                  position: Random().nextDouble() / 2 + 0.5,
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
                  Text(title),
                  SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                  ),
                ],
              ),
              Spacer(),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  size: 20,
                ),
                onSelected: (value) {
                  if (value == "rename")
                    onRename();
                  else if (value == "delete") onDelete();
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
}
