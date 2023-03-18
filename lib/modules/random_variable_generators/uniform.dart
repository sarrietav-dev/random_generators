class UniformDistVariable {
  double a;
  double b;

  UniformDistVariable({required this.a, required this.b});

  double get(double x) {
    return a + (b - a) * x;
  }
}
