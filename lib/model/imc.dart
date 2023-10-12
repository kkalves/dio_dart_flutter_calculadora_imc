import 'package:flutter/material.dart';

class IMC {
  final String _id = UniqueKey().toString();
  double _weight = 0;
  double _height = 0;

  IMC(this._weight, this._height);

  String get id => _id;

  // ignore: unnecessary_getters_setters
  double get weight => _weight;
  set weight(double weight) => _weight = weight;

  // ignore: unnecessary_getters_setters
  double get height => _height;
  set height(double height) => _height = height;
}
