import 'package:flutter_test/flutter_test.dart';
import 'package:random_generators/modules/generators/generator_testers/series_tester.dart';

main() {
  group("Series test", () {
    test("Test 1", () {
      var numbers = [
        0.31,
        0.06,
        0.29,
        0.72,
        0.86,
        0.91,
        0.65,
        0.47,
        0.35,
        0.76
      ];

      var test = SeriesTester(numbers: numbers, intervals: 4);

      closeTo(test.getStatistical(), 7);
      expect(test.test(), true);
    });
  });
}
