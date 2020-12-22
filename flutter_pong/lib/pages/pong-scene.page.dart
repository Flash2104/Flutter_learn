import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pong/objects/ball.dart';
import 'package:flutter_pong/objects/bat.dart';
import 'dart:math';

enum DirectionType { up, down, left, right }

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
  double _randX = 1;
  double _randY = 1;
  double increment = 5;
  double _batWidth = 100;
  double _batHeight = 20;
  double _batPosition = 0;
  DirectionType _vDir = DirectionType.down;
  DirectionType _hDir = DirectionType.right;
  DirectionType _batDir = DirectionType.right;
  int _score = 0;

  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(minutes: 60));
    _animation = Tween<double>(begin: 0, end: 100).animate(_animationController);
    _animation.addListener(() {
      _safeSetState(() {
        (_hDir == DirectionType.right) ? _posX += (_randX*increment).round() : _posX -= (_randX*increment).round();
        (_vDir == DirectionType.down) ? _posY += (_randY*increment).round() : _posY -= (_randY*increment).round();
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
        children: [
          Positioned(child: Text('Score: ${_score.toString()}'), right: 24, top: 0),
          Positioned(child: BallObject(), top: _posY, left: _posX),
          Positioned(
              child: GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  _moveBat(details);
                },
                child: BatObject(_batWidth, _batHeight),

              ),
              bottom: 0,
              left: _batPosition)
        ],
      );
    });
  }

  void _showTryAgain(BuildContext context) {
    showDialog(context: context, builder: (BuildContext ctx) {
      return AlertDialog(
        title: Text('Game Over'),
        content: Text('Would you like to play again?'),
        actions: [
          MaterialButton(
              child: Text('Quit'),
              onPressed: () {
                dispose();
                exit(0);
              }),
          MaterialButton(
          child: Text('Scores'),
          onPressed: () {}),
          MaterialButton(
              child: Text('Play again'),
              onPressed: () {
                setState(() {
                  _posX = 0;
                  _posY = 0;
                  _score = 0;
                });
                Navigator.of(context).pop();
                _animationController.forward();
              }),
        ],
      );
    });
  }

  void _moveBat(DragUpdateDetails details) {
    _safeSetState(() {
      var position = _batPosition + details.delta.dx;
      if (position <= _width - _batWidth / 2 - 50 && position >= 0) {
        _batPosition = position;
        (details.delta.dx > 0) ? _batDir = DirectionType.right : _batDir = DirectionType.left;
      }
    });
  }

  void _checkBorders() {
    double diameter = 50;
    if (_posX <= 0 && _hDir == DirectionType.left) {
      _hDir = DirectionType.right;
      _randX = _randomNumber();
    }
    if (_posX >= _width - diameter && _hDir == DirectionType.right) {
      _hDir = DirectionType.left;
      _randX = _randomNumber();
    }
    if (_posY >= _height - diameter - _batHeight && _vDir == DirectionType.down) {
      if (_posX <= (_batPosition + _batWidth + diameter) && _posX >= (_batPosition - diameter)) {
        _vDir = DirectionType.up;
        _hDir = _batDir;
        _randY = _randomNumber();
        _score++;
      } else {
        _animationController.stop();
        _showTryAgain(context);
      }
    }
    if (_posY <= 0 && _vDir == DirectionType.up) {
      _vDir = DirectionType.down;
      _randY = _randomNumber();
    }
  }

  void _safeSetState(Function func) {
    if(mounted && _animationController.isAnimating) {
      setState(() {
        func();
      });
    }
  }

  double _randomNumber() {
    var ran = Random();
    int myNum = ran.nextInt(101);
    return (50 + myNum) / 100;
  }
}
