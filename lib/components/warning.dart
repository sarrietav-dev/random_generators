import 'package:flutter/material.dart';

class Warning extends StatelessWidget {
  final String message;

  const Warning({required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 20),
        const SizedBox(width: 7.5),
        Text(message, style: const TextStyle(color: Colors.amber)),
      ],
    );
  }
}
