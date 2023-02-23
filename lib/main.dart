import 'package:random_generators/modules/generators/xor_shift.dart';

void main(List<String> args) {
  var method = XorShift(4, int.parse("1001", radix: 2), List.from([1]));
  method.nextBit();
}
