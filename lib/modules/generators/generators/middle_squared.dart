import 'package:random_generators/modules/generators/generator.dart';

class MiddleSquared implements Generator {
  MiddleSquared({required this.seed});

  int seed;

  @override
  int nextNumber() {
    var number = seed * seed;
    var middleNumber = _getMiddleNumber(number);
    seed = middleNumber;
    return middleNumber;
  }

  _getMiddleNumber(int number) {
    var numberString = number.toString();
    var padded = "0" * (8 - numberString.length) + numberString;
    return int.parse(padded.substring(2, 6));
  }
}
