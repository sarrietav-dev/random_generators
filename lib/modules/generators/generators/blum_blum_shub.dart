class BlumBlumShub {
  int p;
  int q;
  int seed;
  int k;

  BlumBlumShub(
      {required this.p, required this.q, required this.seed, this.k = 8}) {
    if (p % 4 != 3 || q % 4 != 3) {
      throw ArgumentError('p and q must be primes of the form 4k+3.');
    }
    p = p;
    q = q;
    seed = seed;
  }

  int _next() {
    int x = seed * seed % (p * q);
    seed = x;
    return x;
  }

  int random() {
    int x = _next();
    return x % 2;
  }

  int nextInt() {
    var number = 0;

    for (var i = 0; i < k; i++) {
      number = number << 1;
      number |= random();
    }

    return number;
  }

  int generate(int n) {
    int result = 0;
    for (int i = 0; i < n; i++) {
      result = 2 * result + random();
    }
    return result;
  }
}
