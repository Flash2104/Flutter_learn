import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  ProductivityButton({@required this.color, @required this.text, @required this.onPressed, @required this.size});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(this.text, style: TextStyle(color: Colors.white)),
      color: this.color,
      onPressed: this.onPressed,
      minWidth: this.size,
    );
  }
}

typedef SettingsButtonFunction = void Function(String, int);

class SettingsButton extends StatelessWidget {
  final Color _color;
  final String _text;
  final int _value;
  final String _key;
  final SettingsButtonFunction _func;

  SettingsButton(this._color, this._text, this._value, this._key, this._func);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        child: Text(this._text, style: TextStyle(color: Colors.white)), color: this._color, onPressed: () => this._func(_key, _value));
  }
}
