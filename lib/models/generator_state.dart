import 'package:flutter/material.dart';
import 'package:random_generators/models/generator_list.dart';
import 'package:random_generators/modules/generators/generator.dart';
import 'package:random_generators/modules/generators/generators/xor_shift.dart';

class GeneratorState extends ChangeNotifier {
  Generator? _generator = null;
  List<int> numbers = [];

  List<String> get generatorNames =>
      ["XorShift", "Mixto", "Multiplicativo", "Blum Blum Shub"];

  GeneratorList _mapIntToGenerator(int index) {
    switch (index) {
      case 0:
        return GeneratorList.xorShift;
      case 1:
        return GeneratorList.mixto;
      case 2:
        return GeneratorList.multiplicativo;
      case 3:
        return GeneratorList.blumBlumShub;
      default:
        return GeneratorList.xorShift;
    }
  }

  void changeGenerator(int index) {
    notifyListeners();
  }

  Generator? getGenerator(GeneratorList generatorList) {
    return null;
  }

  void setNumbers(List<int> newNumbers) {
    numbers = newNumbers;
    notifyListeners();
    print(numbers);
  }
}
