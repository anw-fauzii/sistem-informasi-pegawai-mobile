import 'package:flutter/material.dart';

class MenuUtama extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color color;
  const MenuUtama(
      {super.key,
      required this.title,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: color),
          child: icon,
        ),
        const SizedBox(height: 10),
        Text(title)
      ],
    );
  }
}
