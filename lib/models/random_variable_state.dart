import 'package:flutter/material.dart';

class RandomVariableState extends ChangeNotifier {
  Distributions? _distribution;

  List<String> get distributionNames => [
        "Exponencial",
        "Poisson",
        "Uniforme",
      ];

  set distribution(Distributions value) {
    _distribution = value;
    notifyListeners();
  }

  Distributions? getDistribution() => _distribution;

  mapIntToDistribution(int value) {
    switch (value) {
      case 0:
        return Distributions.exponential;
      case 1:
        return Distributions.poisson;
      case 2:
        return Distributions.uniform;
      default:
        return null;
    }
  }
}

enum Distributions {
  exponential,
  poisson,
  uniform,
}
