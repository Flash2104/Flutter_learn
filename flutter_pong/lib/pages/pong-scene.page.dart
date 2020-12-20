import 'package:flutter/material.dart';
import 'package:flutter_pong/objects/ball.dart';
import 'package:flutter_pong/objects/bat.dart';

class PongScenePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PongSceneState();
  }
}

class _PongSceneState extends State<PongScenePage> {
  double _height;
  double _width;
  double _posX = 0;
  double _posY = 0;
  double _batWidth = 100;
  double _batHeight = 20;
  double _batPosition = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      _width = constraints.maxWidth;
      _height = constraints.maxHeight;
      return Stack(
        children: [
          Positioned(child: BallObject(), top: 0),
          Positioned(child: BatObject(100, 20), bottom: 0)
        ],
      );
    });
  }
}
