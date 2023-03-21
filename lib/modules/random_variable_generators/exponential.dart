import 'dart:math';

import 'package:random_generators/modules/random_variable_generators/random_variable_generator.dart';

class ExponentialDistVariable implements RandomVariableGenerator {
  double lambda;

  ExponentialDistVariable({required this.lambda});

  @override
  double get(double x) {
    return -(lambda) * log(x);
  }
}
