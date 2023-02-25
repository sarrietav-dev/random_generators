import 'package:flutter_test/flutter_test.dart';
import 'package:random_generators/modules/generators/generators/multiplicativo.dart';

main() {
  group("Tests form multiplicativo", () {
    test("It generates the correct series of numbers 1", () {
      var mult = Multiplicativo(a: 5, m: 32, seed: 5);
      var expected = [
        25,
        29,
        17,
        21,
        9,
        13,
        1,
        5,
        25,
        29,
        17,
        21,
        9,
        13,
        1,
        5,
        25,
        29,
        17,
        21,
        9,
        13,
        1,
        5,
        25,
        29,
        17,
        21,
        9,
        13,
        1
      ];

      var states = List.generate(31, (index) => mult.nextNumber());

      expect(states, expected);
    });

    test("It generates the correct series of numbers 2", () {
      var mult = Multiplicativo(a: 17, m: 23, seed: 3);
      var expected = [
        5,
        16,
        19,
        1,
        17,
        13,
        14,
        8,
        21,
        12,
        20,
        18,
        7,
        4,
        22,
        6,
        10,
        9,
        15,
        2,
        11,
        3,
      ];

      var states = List.generate(22, (index) => mult.nextNumber());

      expect(states, expected);
    });
  });
}
