import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'imc_classification.g.dart';

@HiveType(typeId: 1)
class IMCClassification extends HiveObject {
  @HiveField(0)
  double _value = 0;

  @HiveField(1)
  String _description = "";

  @HiveField(2)
  int _color = Colors.green.value;
  // MaterialColor _color = Colors.green;

  @HiveField(3)
  int _icon = Icons.sentiment_very_satisfied.codePoint;

  IMCClassification();

  IMCClassification.createOrUpdate(double value) {
    _value = value;
    if (_value < 16) {
      _description = "Magreza Grave";
      _icon = Icons.sentiment_very_dissatisfied.codePoint;
      _color = Colors.red.value;
    } else if (_value < 17) {
      _description = "Magreza Moderada";
      _icon = Icons.sentiment_neutral.codePoint;
      _color = Colors.amber.value;
    } else if (_value < 18.5) {
      _description = "Magreza Leve";
      _icon = Icons.sentiment_satisfied.codePoint;
      _color = Colors.green.value;
    } else if (_value < 25) {
      _description = "Saudável";
      _icon = Icons.sentiment_very_satisfied.codePoint;
      _color = Colors.green.value;
    } else if (_value < 30) {
      _description = "Sobrepeso";
      _icon = Icons.sentiment_satisfied.codePoint;
      _color = Colors.green.value;
    } else if (_value < 35) {
      _description = "Obesidade Grau I";
      _icon = Icons.sentiment_neutral.codePoint;
      _color = Colors.amber.value;
    } else if (_value < 40) {
      _description = "Obesidade Grau II";
      _icon = Icons.sentiment_dissatisfied.codePoint;
      _color = Colors.orange.value;
    } else {
      _description = "Obesidade Grau III";
      _icon = Icons.sentiment_very_dissatisfied.codePoint;
      _color = Colors.red.value;
    }
  }

  double get value => _value;
  String get description => _description;
  int get icon => _icon;
  int get color => _color;
}
