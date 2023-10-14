import 'package:flutter/material.dart';

class IMCClassification {
  double _value = 0;
  String _description = "";
  MaterialColor _color = Colors.green;
  IconData _icon = Icons.sentiment_very_satisfied;

  IMCClassification(double value) {
    _value = value;
    if (_value < 16) {
      _description = "Magreza Grave";
      _icon = Icons.sentiment_very_dissatisfied;
      _color = Colors.red;
    } else if (_value < 17) {
      _description = "Magreza Moderada";
      _icon = Icons.sentiment_neutral;
      _color = Colors.amber;
    } else if (_value < 18.5) {
      _description = "Magreza Leve";
      _icon = Icons.sentiment_satisfied;
      _color = Colors.green;
    } else if (_value < 25) {
      _description = "Saudável";
      _icon = Icons.sentiment_very_satisfied;
      _color = Colors.green;
    } else if (_value < 30) {
      _description = "Sobrepeso";
      _icon = Icons.sentiment_satisfied;
      _color = Colors.green;
    } else if (_value < 35) {
      _description = "Obesidade Grau I";
      _icon = Icons.sentiment_neutral;
      _color = Colors.amber;
    } else if (_value < 40) {
      _description = "Obesidade Grau II";
      _icon = Icons.sentiment_dissatisfied;
      _color = Colors.orange;
    } else {
      _description = "Obesidade Grau III";
      _icon = Icons.sentiment_very_dissatisfied;
      _color = Colors.red;
    }
  }

  double get value => _value;
  String get description => _description;
  IconData get icon => _icon;
  MaterialColor get color => _color;
}
