import 'package:flutter/material.dart';
import 'package:random_generators/components/generator_form_template.dart';
import 'package:random_generators/models/generator_list.dart';
import 'package:random_generators/modules/generator_widgets/implementations/blum_blum_shub_widget.dart';
import 'package:random_generators/modules/generator_widgets/implementations/lagged_fib_widget.dart';
import 'package:random_generators/modules/generator_widgets/implementations/middle_squared_widget.dart';
import 'package:random_generators/modules/generator_widgets/implementations/mixto_widget.dart';
import 'package:random_generators/modules/generator_widgets/implementations/multiplicativo_widget.dart';
import 'package:random_generators/modules/generator_widgets/implementations/xor_shift_widget.dart';
import 'package:random_generators/modules/generators/generator.dart';

class GeneratorState extends ChangeNotifier {
  GeneratorFormTemplate? currentGenerator;
  List<double> numbers = [];
  List<String> warnings = [];

  List<String> get generatorNames => [
        "XorShift",
        "Mixto",
        "Multiplicativo",
        "Blum Blum Shub",
        "Lagged Fibonacci",
        "Middle Squared"
      ];

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
      case 4:
        return GeneratorList.laggedFibonacci;
      case 5:
        return GeneratorList.middleSquared;
      default:
        return GeneratorList.xorShift;
    }
  }

  void changeGenerator(int index) {
    currentGenerator = _GeneratorTemplateFactory.getGeneratorTemplate(
        _mapIntToGenerator(index));

    clearWarnings();
    clearNumbers();

    notifyListeners();
  }

  void addWarnings(List<String> newWarnings) {
    warnings.addAll(newWarnings);
    notifyListeners();
  }

  void clearWarnings() {
    warnings = [];
    notifyListeners();
  }

  Generator? getGenerator(GeneratorList generatorList) {
    return null;
  }

  void setNumbers(List<double> newNumbers) {
    numbers = newNumbers;
    notifyListeners();
  }

  void clearNumbers() {
    numbers = [];
    notifyListeners();
  }
}

class _GeneratorTemplateFactory {
  static GeneratorFormTemplate getGeneratorTemplate(
      GeneratorList generatorList) {
    switch (generatorList) {
      case GeneratorList.xorShift:
        return XorShiftWidget();
      case GeneratorList.mixto:
        return MixtoWidget();
      case GeneratorList.multiplicativo:
        return MultiplicativoWidget();
      case GeneratorList.blumBlumShub:
        return BlumBlumShubWidget();
      case GeneratorList.middleSquared:
        return MiddleSquaredWidget();
      case GeneratorList.laggedFibonacci:
        return LaggedFibonacciWidget();
    }
  }
}
