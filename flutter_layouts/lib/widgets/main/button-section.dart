import 'package:flutter/material.dart';

typedef ButtonCallbackFunc = Future<void> Function(BuildContext, String);

class ButtonSection extends StatelessWidget {
  final ButtonCallbackFunc callbackFunc;
  const ButtonSection({Key? key, required this.callbackFunc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _buildButtonColumn(Icons.call, context, 'CALL'),
        _buildButtonColumn(Icons.near_me, context, 'ROUTE'),
        _buildButtonColumn(Icons.share, context, 'SHARE')
      ]),
    );
  }

  Column _buildButtonColumn(IconData icon, BuildContext context, String label) {
    final Color color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(icon), onPressed: () => callbackFunc(context, label)),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
