import 'package:dio_dart_flutter_calculadora_imc/imc_calculator_app.dart';
import 'package:dio_dart_flutter_calculadora_imc/model/imc_classification.dart';
import 'package:dio_dart_flutter_calculadora_imc/model/imc_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(IMCModelAdapter());
  Hive.registerAdapter(IMCClassificationAdapter());
  runApp(const IMCCalculatorApp());
}
