import '../generator.dart';

class Multiplicativo extends Generator {
  int a;
  int m;
  int seed;

  Multiplicativo({required this.a, required this.m, required this.seed});

  @override
  int nextNumber() {
    seed = (a * seed) % m;
    return seed;
  }
}
