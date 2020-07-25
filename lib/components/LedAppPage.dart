import 'package:fischi/components/TransparentGradientAppBar.dart';
import 'package:flutter/material.dart';

class LedAppPage extends StatelessWidget {
  final String title;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Widget floatingActionButton;
  final Widget bottomNavigationBar;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget child;

  final bool navigatorPopOnBack;

  const LedAppPage({
    Key key,
    this.title,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
    this.navigatorPopOnBack = false,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentGradientAppBar(
        title: title,
        onBackButtonPressed:
            navigatorPopOnBack ? () => Navigator.pop(context) : null,
      ),
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: WillPopScope(
        onWillPop: () async {
          if (Navigator.of(context).userGestureInProgress)
            return false;
          else
            return true;
        },
        child: child,
      ),
    );
  }
}
