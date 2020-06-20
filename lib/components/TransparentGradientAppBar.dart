import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransparentGradientAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final bool toggleValue;
  final ValueChanged<bool> onToggleChange;

  @override
  _TransparentGradientAppBarState createState() =>
      _TransparentGradientAppBarState();

  TransparentGradientAppBar(
      {Key key, this.toggleValue = true, this.onToggleChange})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;
}

class _TransparentGradientAppBarState extends State<TransparentGradientAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 35,
        ),
        onPressed: () {
          print("back button pressed");
        },
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: CupertinoSwitch(
          activeColor: Theme.of(context).buttonColor,
          value: widget.toggleValue,
          onChanged: (val) {
            if (widget.onToggleChange != null) {
              widget.onToggleChange(val);
            }
          },
        ),
      ),
      flexibleSpace: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.4,
              1,
            ],
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(120, 0, 0, 0),
            ],
          ),
        ),
      ),
    );
  }
}
