import 'package:random_generators/modules/generators/generators/middle_squared.dart';
import 'package:test/test.dart';

main() {
  group("Middle squared", () {
    test("", () {
      var middleSquared = MiddleSquared(seed: 1234);

      var state = List.generate(12, (index) => middleSquared.nextNumber());

      var expected = [
        5227,
        3215,
        3362,
        3030,
        1809,
        2724,
        4201,
        6484,
        422,
        1780,
        1684,
        8358
      ];

      expect(state, expected);
    });
  });
}
