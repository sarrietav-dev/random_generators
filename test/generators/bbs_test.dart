import 'package:flutter_test/flutter_test.dart';
import 'package:random_generators/modules/generators/generators/blum_blum_shub.dart';

main() {
  group("Blum blum shub", () {
    test("", () {
      var bbs = BlumBlumShub(p: 11, q: 19, seed: 3);

      var state = List.generate(12, (index) => bbs.nextInt());

      var expected = [9, 81, 82, 36, 42, 92, 104, 157, 196, 169, 137, 168];

      expect(state, expected);
    });
  });
}
