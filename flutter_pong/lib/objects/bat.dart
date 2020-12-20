import 'package:flutter/material.dart';

class BatObject extends StatelessWidget {
  final double height;
  final double width;
  BatObject(this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.blue[900]
      ),
    );
  }
}
