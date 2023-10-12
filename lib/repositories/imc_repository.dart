
import 'package:dio_dart_flutter_calculadora_imc/model/imc.dart';

class IMCRepository {
  final List<IMC> _imcs = [];

  Future<void> addIMC(IMC imc) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs.add(imc);
  }

  Future<void> updateIMC(String id, double height, double weight) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs.where((imc) => imc.id == id).first.height = height;
    _imcs.where((imc) => imc.id == id).first.weight = weight;
  }

  Future<void> removeIMC(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs.remove(_imcs.where((imc) => imc.id == id).first);
  }

  Future<List<IMC>> getIMCs() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _imcs;
  }
}
