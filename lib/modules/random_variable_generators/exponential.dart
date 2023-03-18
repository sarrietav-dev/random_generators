import 'dart:math';

class ExponentialDistVariable {
  double lambda;

  ExponentialDistVariable({required this.lambda});

  double get(double x) {
    return -log(1 - x) / lambda;
  }
}
