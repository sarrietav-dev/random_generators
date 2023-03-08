import 'package:flutter/material.dart';

abstract class GeneratorTesterWidget extends StatefulWidget {
  const GeneratorTesterWidget({super.key, required this.numbers});
  static const canDeny = "Se puede rechazar la hipotesis nula";
  static const cantDeny = "No se puede rechazar la hipotesis nula";

  final List<double> numbers;

  getColor(bool result) => result ? Colors.green : Colors.red;

  @override
  State<GeneratorTesterWidget> createState();
}
