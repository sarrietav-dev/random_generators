import 'dart:math';

import 'package:random_generators/modules/generator_testers/abstraction/generator_tester.dart';

class MeanTester implements GeneratorTester {
  final List<double> numbers;
  get N => numbers.length;
  get variance => sqrt(1 / 12);
  get mean => numbers.reduce((a, b) => a + b) / N;
  static const tolerance = 1.96;

  MeanTester({required this.numbers});

  _getStatistical() {
    return ((mean - 0.5) * sqrt(N)) / variance;
  }

  @override
  bool test() {
    return _getStatistical().abs() < tolerance;
  }
}
