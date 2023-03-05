import 'dart:math';

import 'abstraction/generator_tester.dart';

class FrecuencyTester implements GeneratorTester {
  final List<double> numbers;
  final int intervals;
  final double tolerance = 1.96;

  List<double> get expectedFrecuencies {
    final expectedFrecuency = N / intervals;
    final expectedFrecuencies =
        List<double>.filled(intervals, expectedFrecuency);
    return expectedFrecuencies;
  }

  get N => numbers.length;

  Map<double, int> get observedFrecuencies {
    Map<double, int> frecuencyMap = {};
    final intervalSize = N / intervals;
    final numbersCopy = List<double>.from(numbers);

    for (var i = intervalSize; i <= N; i += intervalSize) {
      for (int j = 0; j < numbersCopy.length; j++) {
        if (numbersCopy[j] <= i) {
          frecuencyMap[i] = (frecuencyMap[i] ?? 0) + 1;
          numbersCopy.removeAt(j);
          j--;
        }
      }
    }
    return frecuencyMap;
  }

  FrecuencyTester({required this.intervals, required this.numbers});

  double getStatistical() {
    var observedFrecuencies = this.observedFrecuencies;
    var expectedFrecuencies = this.expectedFrecuencies;

    double sum = 0;

    for (var i = 0; i < intervals; i++) {
      final observed = observedFrecuencies[i] ?? 0;
      final expected = expectedFrecuencies[i];

      sum += pow(observed - expected, 2) / expected;
    }

    return sum;
  }

  // Todo: set tolerance to a number in the table

  @override
  bool test() => getStatistical() < tolerance;
}
