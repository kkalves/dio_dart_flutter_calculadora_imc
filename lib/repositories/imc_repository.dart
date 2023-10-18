import 'package:dio_dart_flutter_calculadora_imc/model/imc_model.dart';
import 'package:hive/hive.dart';

class IMCRepository {
  static late Box _box;

  IMCRepository._create();

  static Future<IMCRepository> load() async {
    if (Hive.isBoxOpen('imcModel')) {
      _box = Hive.box('imcModel');
    } else {
      _box = await Hive.openBox('imcModel');
    }
    return IMCRepository._create();
  }

  void create(IMCModel imcModel) {
    _box.add(imcModel);
  }

  void update(IMCModel imcModel) {
    imcModel.save();
  }

  void remove(IMCModel imcModel) {
    imcModel.delete();
  }

  List<IMCModel> getIMCs() {
    // if (isNotCompleted) {
    //   return _box.values
    //       .cast<TaskModel>()
    //       .where((element) => !element.isCompleted)
    //       .toList();
    // } else {
    return _box.values.cast<IMCModel>().toList();
    // }
  }
}
