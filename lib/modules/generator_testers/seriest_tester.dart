import 'dart:math';

import 'package:random_generators/helpers/p_value_map.dart';

import 'abstraction/generator_tester.dart';

class SeriesTester extends GeneratorTester {
  final List<double> numbers;
  final int intervals;

  get intervalSize => 1 / intervals;

  List<List<double>> get pairs {
    var pairs = <List<double>>[];
    for (var i = 0; i < numbers.length - 1; i++) {
      pairs.add([numbers[i], numbers[i + 1]]);
    }
    return pairs;
  }

  get n => numbers.length;

  List<List<int>> get frecuencyMatrix {
    var matrix = <List<int>>[];
    for (var i = 0; i < intervals; i++) {
      matrix.add(List<int>.filled(intervals, 0));
    }
    return matrix;
  }

  get expectedFrecuency => (n - 1) / pow(intervals, 2);

  List<List<int>> setFrecuencyOnMatrix(
      List<List<int>> matrix, List<double> pair) {
    var x = pair[0];
    var y = pair[1];

    var xIndex = (x / intervalSize).floor();
    var yIndex = (y / intervalSize).floor();

    matrix[xIndex][yIndex] += 1;

    return matrix;
  }

  SeriesTester({required this.numbers, required this.intervals});

  @override
  double getStatistical() {
    var frecuencyMatrix = this.frecuencyMatrix;

    for (var pair in pairs) {
      frecuencyMatrix = setFrecuencyOnMatrix(frecuencyMatrix, pair);
    }

    var firstExpresion = pow(n, 2) / (n - 1);

    var sum = 0.0;
    for (var i = 0; i < intervals; i++) {
      double jSum = 0;
      for (var j = 0; j < intervals; j++) {
        jSum += pow(frecuencyMatrix[i][j] - ((n - 1) / pow(n, 2)), 2).toDouble();
      }

      sum += jSum;
    }

    return firstExpresion * sum;
  }

  @override
  bool test() {
    var statistical = getStatistical();
    return statistical < (pValueMap[pow(n - 1, 2).toInt()] ?? -1);
  }
}
