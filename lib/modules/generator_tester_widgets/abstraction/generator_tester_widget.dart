import 'package:flutter/material.dart';

abstract class GeneratorTesterWidget extends StatefulWidget {
  const GeneratorTesterWidget({super.key, required this.numbers});

  final List<double> numbers;

  getColor(bool result) => result ? Colors.green : Colors.red;

  @override
  State<GeneratorTesterWidget> createState();
}
