import 'package:flutter/material.dart';

abstract class GeneratorFormWidget extends StatelessWidget {
  const GeneratorFormWidget({super.key});

  List<int> getNumbers();

  @override
  Widget build(BuildContext context);
}