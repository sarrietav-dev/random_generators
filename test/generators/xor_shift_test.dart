import 'package:random_generators/modules/generators/generators/xor_shift.dart';
import 'package:test/test.dart';

void main() {
  group("1001 XOR_shift tests", () {
    test("The first state is 1100", () {
      var xor =
          XorShift(k: 8, n: 4, seed: int.parse("1001", radix: 2), taps: [1]);

      xor.nextBit();

      expect(xor.state, "1100");
    });

    test("The second state is 0110", () {
      var xor =
          XorShift(k: 8, n: 4, seed: int.parse("1100", radix: 2), taps: [1]);

      xor.nextBit();

      expect(xor.state, "0110");
    });

    test("It generates the first 10 numbers", () {
      var xor =
          XorShift(k: 8, n: 4, seed: int.parse("1001", radix: 2), taps: [1]);

      List list = [];

      for (var i = 0; i < 16; i++) {
        list.add(xor.nextNumber());
      }

      expect(
          list,
          List.from([
            53,
            226,
            107,
            196,
            215,
            137,
            175,
            19,
            94,
            38,
            188,
            77,
            120,
            154,
            241,
            53,
          ]));
    });
  });
}
