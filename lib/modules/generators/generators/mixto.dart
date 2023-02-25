import 'package:flutter/material.dart';
import 'package:random_generators/validators/validators.dart';

import '../generator.dart';

class Mixto implements Generator {
  int a;
  int c;
  int m;
  int seed;

  Mixto(
      {required this.a, required this.c, required this.m, required this.seed}) {
    if (m <= 0) throw Exception("m must be greater than 0");
    if (a <= 0) throw Exception("a must be greater than 0");
    if (c <= 0) throw Exception("c must be greater than 0");
    if (seed <= 0) throw Exception("seed must be greater than 0");
    if (a >= m) throw Exception("a must be less than m");
    if (c >= m) throw Exception("c must be less than m");
    if (seed >= m) throw Exception("seed must be less than m");
    if (!Validators.isLesserThanArquitecture(m)) {
      throw Exception("m must be less than 2^32");
    }
  }

  @override
  int nextNumber() {
    seed = (a * seed + c) % m;
    return seed;
  }
}
