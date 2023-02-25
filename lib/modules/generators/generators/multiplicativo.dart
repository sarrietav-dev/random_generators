import '../../../validators/validators.dart';
import '../generator.dart';

class Multiplicativo extends Generator {
  int a;
  int m;
  int seed;

  Multiplicativo({required this.a, required this.m, required this.seed}) {
    if (m <= 0) throw Exception("m must be greater than 0");
    if (a <= 0) throw Exception("a must be greater than 0");
    if (seed <= 0) throw Exception("seed must be greater than 0");
    if (a >= m) throw Exception("a must be less than m");
    if (seed >= m) throw Exception("seed must be less than m");
    if (!Validators.isLesserThanArquitecture(m)) {
      throw Exception("m must be less than 2^32");
    }
  }

  @override
  int nextNumber() {
    seed = (a * seed) % m;
    return seed;
  }
}
