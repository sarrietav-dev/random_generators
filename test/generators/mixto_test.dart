import 'package:flutter_test/flutter_test.dart';
import 'package:random_generators/modules/generators/generators/mixto.dart';

main() {
  group("Mixto test", () {
    test("The first state is 3", () {
      var a = 5;
      var c = 7;
      var m = 8;
      var seed = 4;

      var mixto = Mixto(a: a, c: c, m: m, seed: seed);

      expect(mixto.nextNumber(), 3);
    });

    group("It generates the correct sequence of numbers", () {
      var seed = 3;
      var a = 17;
      var c = 13;
      var m = 23;

      test("The first state is 18", () {
        var mixto = Mixto(a: a, c: c, m: m, seed: seed);

        expect(mixto.nextNumber(), 18);
      });

      test("It is period complete", () {
        var mixto = Mixto(a: a, c: c, m: m, seed: seed);

        var states = List.generate(m - 1, (index) => mixto.nextNumber());

        var expectedResponse = [
          18,
          20,
          8,
          11,
          16,
          9,
          5,
          6,
          0,
          13,
          4,
          12,
          10,
          22,
          19,
          14,
          21,
          2,
          1,
          7,
          17,
          3,
        ];

        expect(states.length, expectedResponse.length);
        expect(states, expectedResponse);
      });
    });
  });
}
