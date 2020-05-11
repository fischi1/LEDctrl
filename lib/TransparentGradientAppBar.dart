import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransparentGradientAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  @override
  _TransparentGradientAppBarState createState() =>
      _TransparentGradientAppBarState();

  TransparentGradientAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;
}

class _TransparentGradientAppBarState extends State<TransparentGradientAppBar> {
  bool _toggleVal = true;

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
          value: _toggleVal,
          onChanged: (val) {
            setState(() {
              _toggleVal = !_toggleVal;
            });
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
