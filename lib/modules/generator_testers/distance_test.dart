import 'dart:math';

import 'package:random_generators/modules/generator_testers/abstraction/generator_tester.dart';

class DistanceTest implements GeneratorTester {
  List<double> numbers;

  DistanceTest({required this.numbers});

  get binaryArray {
    List<double> binaryArray = [];

    for (var number in numbers) {
      binaryArray.add(number < 0.5 ? 0 : 1);
    }

    return binaryArray;
  }

  List<int> getCount(List<double> binaryArray) {
    var zeroCount = binaryArray.takeWhile((value) => value == 0).length;
    var oneCount = binaryArray.takeWhile((value) => value == 1).length;

    return [zeroCount, oneCount];
  }

  getUCorridas(List<int> countArray, List<double> binaryArray) {
    var zeroCount = countArray[0];
    var oneCount = countArray[1];

    return ((2 * oneCount * zeroCount / binaryArray.length + 1) + 0.5);
  }

  double getVarianceCorridas(List<int> countArray, List<double> binaryArray) {
    var zeroCount = countArray[0];
    var oneCount = countArray[1];

    return ((2 *
            oneCount *
            zeroCount *
            (2 * oneCount * zeroCount - binaryArray.length)) /
        (binaryArray.length * binaryArray.length * (binaryArray.length - 1)));
  }

  double getCorridasCount(List<double> binaryArray) {
    double corridasCount = 0;

    for (var i = 0; i < binaryArray.length - 1; i++) {
      if (binaryArray[i] != binaryArray[i + 1]) {
        corridasCount++;
      }
    }

    return corridasCount;
  }

  getStandardDeviationCorridas(double variance) {
    return sqrt(variance);
  }

  getZCorridas(
      double uCorridas, double corridasCount, double standardDeviation) {
    return ((corridasCount - uCorridas) / standardDeviation).abs();
  }

  @override
  double getStatistical() {
    var binaryArray = this.binaryArray;

    var countArray = getCount(binaryArray);

    var uCorridas = getUCorridas(countArray, binaryArray);

    var stdDev = getStandardDeviationCorridas(
        getVarianceCorridas(countArray, binaryArray));

    var corridasCount = getCorridasCount(binaryArray);

    return getZCorridas(uCorridas, corridasCount, stdDev);
  }

  @override
  bool test() {
    var zAlpha = 1.96;

    return getStatistical() < zAlpha;
  }
}
