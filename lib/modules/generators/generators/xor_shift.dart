import '../generator.dart';

class XorShift implements Generator {
  int n;
  int seed;
  List<int> taps;
  int k;

  XorShift(
      {required this.n,
      required this.seed,
      required this.taps,
      required this.k});

  get state {
    var radixString = seed.toRadixString(2);
    if (radixString.length == 3) return "0$radixString";
    return radixString;
  }

  int nextBit() {
    var state = seed;

    for (var tap in taps) {
      state = state ^ (state >> tap);
    }

    var newBit = state & 1;

    seed = (seed >> 1) | (newBit << (n - 1));

    return seed & 1;
  }

  int nextNumber() {
    var number = 0;

    for (var i = 0; i < k; i++) {
      number = number << 1;
      number |= nextBit();
    }

    return number;
  }
}
