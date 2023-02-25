import 'package:flutter/material.dart';

import '../generator.dart';

class Mixto implements Generator {
  int a;
  int c;
  int m;
  int seed;

  Mixto({required this.a, required this.c, required this.m, required this.seed});

  @override
  int nextNumber() {
    seed = (a * seed + c) % m;
    return seed;
  }
}