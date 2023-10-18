import 'package:dio_dart_flutter_calculadora_imc/model/imc_classification.dart';
import 'package:dio_dart_flutter_calculadora_imc/service/calculate_imc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'imc_model.g.dart';

@HiveType(typeId: 0)
class IMCModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  double? weight;

  @HiveField(2)
  double? height;

  @HiveField(3)
  IMCClassification? imcClassification;

  IMCModel();

  IMCModel.create(this.weight, this.height) {
    id = UniqueKey().toString();
    imcClassification =
        IMCClassification.createOrUpdate(CalculateIMC.calculateIMC(weight!, height!));
  }
}
