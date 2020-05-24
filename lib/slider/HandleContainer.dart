import 'package:flutter/material.dart';

import 'LedHandle.dart';

class HandleContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        height: 50,
        width: 50,
        color: Colors.white,
        child: LedHandle(
          offset: Offset(25, 25),
          color: Colors.purple,
        ),
      ),
    );
  }
}
