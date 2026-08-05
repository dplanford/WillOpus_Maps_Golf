import 'dart:math';

class MathHelper {
  static double logBase(double x, double base) => log(x) / log(base);

  static double log2(double x) => logBase(x, 2.0);

  static double avrg(double x, double y) => (x + y) / 2.0;
}
