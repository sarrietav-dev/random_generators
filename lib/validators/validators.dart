import 'dart:math';

class Validators {
  static bool isPrime(int value) {
    if (value == 1) {
      return false;
    }
    for (int i = 2; i < value; i++) {
      if (value % i == 0) {
        return false;
      }
    }
    return true;
  }

  static bool isCoprime(int a, int b) {
    return gcd(a, b) == 1;
  }

  static int gcd(int a, int b) {
    if (b == 0) {
      return a;
    }
    return gcd(b, a % b);
  }

  static bool isTheModulus5WhenDividedBy8(int value) {
    return value % 8 == 5;
  }

  static bool isGreaterThanValues(int m, List<int> a) {
    for (var num in a) {
      if (m <= num) {
        return false;
      }
    }
    return true;
  }

  static bool isLesserThanArquitecture(int value) {
    return value < pow(2, 32 - 1);
  }
}
