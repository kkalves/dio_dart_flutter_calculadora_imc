import 'package:dio_dart_flutter_calculadora_imc/model/imc_classification.dart';
import 'package:dio_dart_flutter_calculadora_imc/service/calculate_imc.dart';
import 'package:flutter/material.dart';

class IMC {
  final String _id = UniqueKey().toString();
  double _weight = 0;
  double _height = 0;
  IMCClassification _classification = IMCClassification(0);

  IMC(double weight, double height) {
    _weight = weight;
    _height = height;
    _classification =
        IMCClassification(CalculateIMC.calculateIMC(weight, height));
  }

  String get id => _id;

  // ignore: unnecessary_getters_setters
  double get weight => _weight;
  set weight(double weight) => _weight = weight;

  // ignore: unnecessary_getters_setters
  double get height => _height;
  set height(double height) => _height = height;

  // ignore: unnecessary_getters_setters
  IMCClassification get classification => _classification;
  set classification(IMCClassification classification) =>
      _classification = classification;
}
