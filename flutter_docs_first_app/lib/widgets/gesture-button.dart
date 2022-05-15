import 'package:flutter/material.dart';

class GestureButton extends StatelessWidget {
  const GestureButton({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Button was tapped!'),
      onVerticalDragEnd: (details) => print('Button was downed!'),
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500]
        ),
        child: const Center(
          child: Text('Gesture'),
        ),
      ),
    );
  }
}