import 'package:flutter/material.dart';

class CustomCheckItem extends StatelessWidget {
  final String text;

  const CustomCheckItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.circle_outlined, size: 12),
        const SizedBox(width: 6),
        Expanded(child: Text(text)),
      ],
    );
  }
}
