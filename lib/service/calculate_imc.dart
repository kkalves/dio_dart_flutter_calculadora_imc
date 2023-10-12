import 'dart:math';

import 'package:dio_dart_flutter_calculadora_imc/model/imc.dart';

class CalculateIMC {
  static double calculateIMC(IMC imc) {
    return imc.weight / pow((imc.height), 2);
  }
}
