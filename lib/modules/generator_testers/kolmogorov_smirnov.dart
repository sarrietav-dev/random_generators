import 'package:random_generators/modules/generator_testers/abstraction/generator_tester.dart';

class KolmogorovSmirnovTest implements GeneratorTester {
  final List<double> numbers;

  KolmogorovSmirnovTest({required this.numbers});

  @override
  double getStatistical() {
    // TODO: implement getStatistical
    throw UnimplementedError();
  }

  @override
  bool test() {
    // TODO: implement test
    throw UnimplementedError();
  }
}
