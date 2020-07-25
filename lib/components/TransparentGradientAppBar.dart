import 'package:fischi/components/OnOffSwitch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LedBackButton extends StatelessWidget {
  final Function onPressed;

  const LedBackButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 35,
      ),
      onPressed: onPressed,
    );
  }
}

class TransparentGradientAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Function onBackButtonPressed;
  final String title;

  TransparentGradientAppBar({
    Key key,
    this.onBackButtonPressed,
    this.title = "",
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          if (onBackButtonPressed != null)
            return LedBackButton(
              onPressed: onBackButtonPressed,
            );
          return Container();
        },
      ),
      actions: <Widget>[
        OnOffSwitch(),
        SizedBox(
          width: 5,
        )
      ],
      title: Text(title),
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
