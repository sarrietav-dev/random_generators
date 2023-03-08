import 'dart:math';

import 'package:random_generators/modules/generator_testers/abstraction/generator_tester.dart';

class KolmogorovSmirnovTest implements GeneratorTester {
  final List<double> numbers;

  KolmogorovSmirnovTest({required this.numbers});

  @override
  double getStatistical() {
    var sortedNumbers = numbers.toList()..sort();
    List<double> fx = [];

    for (var i = 1; i <= sortedNumbers.length; i++) {
      fx.add(i / sortedNumbers.length);
    }

    List<double> fxMinusX = [];

    for (var i = 0; i < sortedNumbers.length; i++) {
      fxMinusX.add(fx[i] - sortedNumbers[i]);
    }

    var max = fxMinusX.reduce((a, b) => a > b ? a : b);

    return max;
  }

  @override
  bool test() {
    var statistical = getStatistical();
    var alpha = numbers.length <= 20
        ? a[numbers.length - 1]
        : 1.36 / sqrt(numbers.length);

    return statistical < alpha;
  }
}

var a = [
  0.975,
  0.842,
  0.708,
  0.624,
  0.563,
  0.521,
  0.486,
  0.457,
  0.432,
  0.409,
  0.391,
  0.375,
  0.961,
  0.949,
  0.338,
  0.328,
  0.318,
  0.309,
  0.301,
  0.294,
];
