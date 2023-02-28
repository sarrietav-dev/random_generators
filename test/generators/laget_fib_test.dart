import 'package:flutter_test/flutter_test.dart';
import 'package:random_generators/modules/generators/generators/lagged_fib.dart';

main() {
  group("Lagged fib tests", () {
    test("It generates a random series of numbers correclty", () {
      var laggerdFib = LaggedFibonacci(seed: 6421893, mod: 10);

      var expected = [
        5,
        6,
        4,
        3,
        6,
        1,
        7,
        1,
        4,
        0,
        1,
        8,
        9,
        3,
        3,
        4,
        2,
        1,
        4,
        7
      ];

      var actual = List.generate(20, (index) => laggerdFib.nextNumber());

      expect(actual, expected);
    });
  });
}
