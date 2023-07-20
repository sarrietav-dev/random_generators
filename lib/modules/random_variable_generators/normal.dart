import 'dart:math';

class NormalDistVariable {
  NormalDistVariable({
    required this.estDev,
    required this.mean,
  });

  final double estDev;
  final double mean;

  List<double> get(double u1, double u2) {
    var z1 = sqrt(-2 * log(u1)) * cos(2 * pi * u2);
    var z2 = sqrt(-2 * log(u1)) * sin(2 * pi * u2);

    return [z1, z2]; 
  }

}
