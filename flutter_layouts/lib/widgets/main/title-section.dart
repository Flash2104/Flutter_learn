import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: const Text('Мужчина, родился 8 мая 1989',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Text(
                'Московский государственный технический университет им. Н.Э. Баумана, Москва',
                style: TextStyle(color: Colors.grey[500]),
              )
            ],
          ),
        ),
        Icon(Icons.star, color: Colors.red[500]),
        const Text('33 года')
      ]),
    );
  }
}
