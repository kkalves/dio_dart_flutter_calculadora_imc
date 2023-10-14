import 'dart:math';

class CalculateIMC {
  static double calculateIMC(double weight, double height) {
    return weight / pow((height), 2);
  }
}
