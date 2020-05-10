import 'package:flutter/material.dart';

class TransparentGradientAppBar extends AppBar {
  TransparentGradientAppBar()
      : super(
          elevation: 0,
          title: Icon(
            Icons.arrow_back,
            size: 35,
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
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
