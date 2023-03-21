import 'dart:math';

import 'package:random_generators/modules/random_variable_generators/random_variable_generator.dart';

class PoissonDistVariable implements RandomVariableGenerator {
  final double lambda;
  List<double> limits = [];

  PoissonDistVariable({required this.lambda});

  @override
  double get(double x) {
    if (x < 0 || x > 1) {
      throw ArgumentError("X must be between 0 and 1");
    }

    if (limits.isEmpty) {
      limits = _getLimitList(40);
    }

    return _evaluateInLimits(x, limits);
  }

  double _evaluateInLimits(double x, List<double> searchRange) {
    var middle = searchRange.length ~/ 2;

    if (middle == 1) {
      return limits.indexOf(searchRange[middle - 1]).toDouble();
    }

    if (searchRange[middle - 1] <= x && x < searchRange[middle]) {
      return limits.indexOf(searchRange[middle - 1]).toDouble();
    }

    if (x < searchRange[middle - 1]) {
      return _evaluateInLimits(x, searchRange.sublist(0, middle));
    } else {
      return _evaluateInLimits(x, searchRange.sublist(middle));
    }
  }

  double _getLimit(int x) {
    return (BigInt.from(lambda).pow(x).toDouble() * exp(-lambda)) /
        BigInt.from(_factorial(x)).toDouble();
  }

  double _factorial(int x) {
    if (x == 0) {
      return 1;
    } else {
      return x * _factorial(x - 1);
    }
  }

  _getLimitList(int length) {
    List<double> list = [0];

    for (var i = 0; i < length; i++) {
      var upperLimit = list.last + _getLimit(i);

      if (upperLimit > 0.999) {
        return list;
      }

      list.add(upperLimit);
    }

    return list;
  }
}
