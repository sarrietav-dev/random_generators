import 'package:random_generators/modules/generators/generator.dart';

class LaggedFibonacci implements Generator {
  LaggedFibonacci({required this.seed, required this.mod});

  final int seed;
  final int mod;
  final int _j = 2;
  final int _k = 6;
  List<int> _digits = [];

  @override
  int nextNumber() {
    if (_digits.isEmpty) {
      _digits = splitNumber(seed);
    }

    var j = _digits[_j];
    var k = _digits[_k];

    var sum = k + j;
    var digit = sum % mod;

    _digits.removeAt(0);
    _digits.add(digit);

    return digit;
  }

  List<int> splitNumber(int number) {
    var list = number.toString().split("");
    return list.map((e) => int.parse(e)).toList();
  }
}
