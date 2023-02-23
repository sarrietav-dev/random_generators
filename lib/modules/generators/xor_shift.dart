class XorShift {
  int n;
  int seed;
  List<int> taps;

  XorShift(this.n, this.seed, this.taps);

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

  int nextInt(int k) {
    var number = 0;

    for (var i = 0; i < k; i++) {
      number = number << 1;
      number |= nextBit();
    }

    return number;
  }
}
