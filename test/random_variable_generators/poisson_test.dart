import 'package:flutter_test/flutter_test.dart';
import 'package:random_generators/modules/random_variable_generators/poisson.dart';

void main() {
  group("Poisson distribution variable", () {
    test("maps 0.586206897 with the interval 21", () {
      var poisson = PoissonDistVariable(lambda: 20);

      expect(poisson.get(0.586206897), 21);
    });

    test("maps 0.896551724 with the interval 26", () {
      var poisson = PoissonDistVariable(lambda: 20);

      expect(poisson.get(0.896551724), 26);
    });

    test("maps 0 with the interval 0", () {
      var poisson = PoissonDistVariable(lambda: 20);

      expect(poisson.get(0), 0);
    });

    test("maps 0.99999 with the interval ?", () {
      var poisson = PoissonDistVariable(lambda: 20);

      expect(poisson.get(0.9999999), 33);
    });

    test("X cannot be negative", () {
      var poisson = PoissonDistVariable(lambda: 20);

      expect(() => poisson.get(-1), throwsA(isA<ArgumentError>()));
    });

    test("X cannot be greater than 1", () {
      var poisson = PoissonDistVariable(lambda: 20);

      expect(() => poisson.get(2), throwsA(isA<ArgumentError>()));
    });
  });
}
