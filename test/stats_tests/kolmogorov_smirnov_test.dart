import 'package:flutter_test/flutter_test.dart';
import 'package:random_generators/modules/generators/generator_testers/kolmogorov_smirnov.dart';

void main() {
  group("Kolmogorov-Smirnov test", () {
    test("Kolmogorov-Smirnov test", () {
      var numbers = [
        0.675675676,
        0.378378378,
        0.891891892,
        0.459459459,
        0.297297297,
        0.486486486,
        0.432432432,
        0.162162162,
        0.810810811,
        0.054054054,
        0.27027027,
        0.351351351,
        0.756756757,
        0.783783784,
        0.918918919,
        0.594594595,
        0.972972973,
        0.864864865,
        0.324324324,
        0.621621622,
        0.108108108,
        0.540540541,
        0.702702703,
        0.513513514,
        0.567567568,
        0.837837838,
        0.189189189,
        0.945945946,
        0.72972973,
        0.648648649,
        0.243243243,
        0.216216216,
        0.081081081,
        0.405405405,
        0.027027027,
        0.135135135,
      ];

      var test = KolmogorovSmirnovTest(numbers: numbers);

      closeTo(test.getStatistical(), 0.027027027);
      expect(test.test(), true);
    });
  });
}
