import 'package:flutter/material.dart';

class ProgressButton extends StatefulWidget {
  final Widget text;
  final bool inProgress;
  final Function onPressed;

  const ProgressButton({
    Key key,
    this.text,
    this.inProgress,
    this.onPressed,
  }) : super(key: key);

  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.inProgress)
      _animationController.forward();
    else
      _animationController.reverse();

    return RaisedButton(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: UnconstrainedBox(
        child: Row(
          children: <Widget>[
            SizeTransition(
              axis: Axis.horizontal,
              axisAlignment: -1,
              sizeFactor: _animationController,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 1, top: 2, right: 2, bottom: 2),
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    ),
                  ),
                  SizedBox(width: 8)
                ],
              ),
            ),
            widget.text,
          ],
        ),
      ),
      onPressed: widget.inProgress ? null : widget.onPressed,
    );
  }
}
