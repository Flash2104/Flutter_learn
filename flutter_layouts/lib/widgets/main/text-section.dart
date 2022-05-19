import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  const TextSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        '• Developer C#/Angular Информационные технологии, интернет, телеком;\n'
        '• Программирование, Разработка;\n'
        '• Занятость: полная занятость;\n'
        '• График работы: гибкий график, полный день;\n'
        '• Желательное время в пути до работы: не более полутора часов;\n',
        softWrap: true,
      ),
    );
  }
}
