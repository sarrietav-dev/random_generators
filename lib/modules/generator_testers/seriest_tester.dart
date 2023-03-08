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

  List<List<double>> get frecuencyMatrix {
    var matrix = <List<double>>[];
    for (var i = 0; i < intervals; i++) {
      matrix.add(List<double>.filled(intervals, 0));
    }
    return matrix;
  }

  get expectedFrecuency => (n - 1) / pow(intervals, 2);

  List<List<double>> setFrecuencyOnMatrix(
      List<List<double>> matrix, List<double> pair) {
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

    var sum = 0.0;
    for (var j = 0; j < intervals; j++) {
      for (var i = 0; i < intervals; i++) {
        sum += pow(frecuencyMatrix[i][j] - expectedFrecuency, 2) /
            expectedFrecuency;
      }
    }

    return sum;
  }

  @override
  bool test() {
    var statistical = getStatistical();
    return statistical < (pValueMap[pow(n - 1, 2).toInt()] ?? -1);
  }
}
