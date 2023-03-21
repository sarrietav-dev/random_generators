import 'package:flutter/material.dart';

class RandomVariableState extends ChangeNotifier {
  Distributions? _distributionType;
  List<double> _randomVariables = [];
  List<double> _randomNumbers = [];

  set randomVariables(List<double> value) {
    _randomVariables = value;
    notifyListeners();
  }

  List<double> get randomVariables => _randomVariables;

  set randomNumbers(List<double> value) {
    _randomNumbers = value;
    notifyListeners();
  }

  List<double> get randomNumbers => _randomNumbers;

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
}

enum Distributions {
  exponential,
  poisson,
  uniform,
}
