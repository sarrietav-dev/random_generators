import 'package:random_generators/modules/generators/generator_testers/mean_tester.dart';
import 'package:test/test.dart';

main() {
  group("Mean Test", () {
    test("works", () {
      final numbers = [
        0.78261,
        0.86957,
        0.34783,
        0.47826,
        0.69565,
        0.39130,
        0.21739,
        0.26087,
        0.00000,
        0.56522,
        0.17391,
        0.52174,
        0.43478,
        0.95652,
        0.82609,
        0.60870,
        0.91304,
        0.08696,
        0.04348,
        0.30435,
        0.73913,
        0.13043,
        0.78261,
        0.78261,
        0.86957,
        0.34783,
        0.47826,
        0.69565,
        0.39130,
        0.21739,
        0.26087,
        0.00000,
        0.56522,
        0.17391,
        0.52174,
        0.43478,
        0.95652,
        0.82609,
        0.60870,
        0.91304,
        0.08696,
        0.04348,
        0.30435,
        0.73913,
        0.13043,
        0.78261,
      ];

      final tester = MeanTester(numbers: numbers);

      expect(tester.test(), true);
    });
  });
}
