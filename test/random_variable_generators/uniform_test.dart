import 'package:flutter_test/flutter_test.dart';
import 'package:random_generators/modules/random_variable_generators/uniform.dart';

void main() {
  group("Uniform distribution variable generator", () {
    test("works", () {
      List<double> randomNumbers = [
        0.48,
        0.82,
        0.69,
        0.67,
        0,
      ];

      List<double> expectedVariables = [
        97.4,
        99.1,
        98.45,
        98.35,
        95,
      ];

      var uniform = UniformDistVariable(
        a: 95,
        b: 100,
      );

      for (var i = 0; i < randomNumbers.length; i++) {
        closeTo(uniform.get(randomNumbers[i]), expectedVariables[i]);
      }
    });
  });
}
