import 'package:flutter/material.dart';
import 'package:flutter_pong/objects/ball.dart';
import 'package:flutter_pong/objects/bat.dart';

enum BallDirection { up, down, left, right }

class PongScenePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PongSceneState();
  }
}

class _PongSceneState extends State<PongScenePage> with SingleTickerProviderStateMixin {
  double _height;
  double _width;
  double _posX = 0;
  double _posY = 0;
  double increment = 5;
  double _batWidth = 100;
  double _batHeight = 20;
  double _batPosition = 0;
  BallDirection _vDir = BallDirection.down;
  BallDirection _hDir = BallDirection.right;

  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(minutes: 60));
    _animation = Tween<double>(begin: 0, end: 100).animate(_animationController);
    _animation.addListener(() {
      setState(() {
        (_hDir == BallDirection.right) ? _posX += increment : _posX -= increment;
        (_vDir == BallDirection.down) ? _posY += increment : _posY -= increment;
      });
      _checkBorders();
    });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      _width = constraints.maxWidth;
      _height = constraints.maxHeight;
      return Stack(
        children: [Positioned(child: BallObject(), top: _posY, left: _posX), Positioned(child: BatObject(100, 20), bottom: 0)],
      );
    });
  }

  void _checkBorders() {
    if (_posX <= 0 && _hDir == BallDirection.left) {
      _hDir = BallDirection.right;
    }
    if (_posX >= _width - 50 && _hDir == BallDirection.right) {
      _hDir = BallDirection.left;
    }
    if (_posY >= _height - 50 && _vDir == BallDirection.down) {
      _vDir = BallDirection.up;
    }
    if (_posY <= 0 && _vDir == BallDirection.up) {
      _vDir = BallDirection.down;
    }
  }
}
