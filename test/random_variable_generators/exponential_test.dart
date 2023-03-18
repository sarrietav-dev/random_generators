import 'package:flutter_test/flutter_test.dart';
import 'package:random_generators/modules/random_variable_generators/exponential.dart';

void main() {
  group("Exponential distribution test", () {
    test("works", () {
      List<double> randomNumbers = [
        0.64,
        0.83,
        0.03,
        0.5,
        0.21,
      ];

      List<double> expectedRandomVariables = [
        0.340550416,
        0.590652281,
        0.010153069,
        0.23104906,
        0.078574111,
      ];

      var exponential = ExponentialDistVariable(lambda: 3);

      for (var i = 0; i < randomNumbers.length; i++) {
        closeTo(exponential.get(randomNumbers[i]), expectedRandomVariables[i]);
      }
    });
  });
}
