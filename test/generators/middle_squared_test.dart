import 'package:random_generators/modules/generators/generators/middle_squared.dart';
import 'package:test/test.dart';

main() {
  group("Middle squared", () {
    test("", () {
      var middleSquared = MiddleSquared(seed: 1234);

      var state = List.generate(12, (index) => middleSquared.nextNumber());

      var expected = [
        1234,
        1522756,
        233250176,
        547608345,
        299593728,
        889569024,
        792351744,
        641163264,
        410485504,
        168099584,
        282475249,
        797664430
      ];

      expect(state, expected);
    });
  });
}
