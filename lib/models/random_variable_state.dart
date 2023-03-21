import 'package:flutter/material.dart';

class RandomVariableState extends ChangeNotifier {
  Distributions? _distributionType;

  List<String> get distributionNames => [
        "Exponencial",
        "Poisson",
        "Uniforme",
      ];

  set distribution(Distributions value) {
    _distributionType = value;
    notifyListeners();
  }

  Distributions? getDistribution() => _distributionType;

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

  getRandomVariables(List<double> randomNumbers) {

  }
}

enum Distributions {
  exponential,
  poisson,
  uniform,
}
