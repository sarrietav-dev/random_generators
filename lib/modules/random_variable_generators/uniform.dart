import 'package:random_generators/modules/random_variable_generators/random_variable_generator.dart';

class UniformDistVariable implements RandomVariableGenerator {
  double a;
  double b;

  UniformDistVariable({required this.a, required this.b});

  @override
  double get(double x) {
    return a + (b - a) * x;
  }
}
