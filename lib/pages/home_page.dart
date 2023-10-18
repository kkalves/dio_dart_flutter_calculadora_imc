import 'package:dio_dart_flutter_calculadora_imc/model/imc_classification.dart';
import 'package:dio_dart_flutter_calculadora_imc/model/imc_model.dart';
import 'package:dio_dart_flutter_calculadora_imc/repositories/imc_repository.dart';
import 'package:dio_dart_flutter_calculadora_imc/service/calculate_imc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late IMCRepository imcRepository;
  var _imcs = <IMCModel>[];

  double _currentWeightSliderValue = 0;
  double _currentHeightSliderValue = 0;

  bool isSaving = false;
  // bool isListExtended = false;
  int checkedIndex = -1;

  void loadIMC() async {
    imcRepository = await IMCRepository.load();
    _imcs = imcRepository.getIMCs();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadIMC();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        leading: const Icon(Icons.calculate),
        title: const Text(
          "Calculadora de IMC",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: isSaving
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _imcs.length,
                    itemBuilder: (context, index) {
                      var imc = _imcs[index];
                      return ListTile(
                        leading: Icon(
                            IconData(imc.imcClassification!.icon,
                                fontFamily: 'MaterialIcons'),
                            color: Color(imc.imcClassification!.color)),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(imc.imcClassification!.description,
                                style: TextStyle(
                                    color: Color(imc.imcClassification!.color),
                                    fontWeight: FontWeight.bold)),
                            Text(
                                imc.imcClassification!.value.toStringAsFixed(2),
                                style: TextStyle(
                                    color: Color(imc.imcClassification!.color),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        subtitle: (checkedIndex == index)
                            ? Text(
                                "Peso: ${imc.weight?.toStringAsFixed(2)}kg Altura: ${imc.height?.toStringAsFixed(2)}",
                                style: const TextStyle(color: Colors.blue),
                              )
                            : null,
                        onTap: () {
                          setState(() {
                            if (checkedIndex == index) {
                              checkedIndex = -1;
                            } else {
                              checkedIndex = index;
                            }
                          });
                        },
                        trailing: PopupMenuButton(
                            onSelected: (value) {},
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  key: Key(imc.id!),
                                  value: "update",
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Editar",
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(Icons.edit, color: Colors.amber),
                                    ],
                                  ),
                                  onTap: () {
                                    _currentWeightSliderValue = imc.weight!;
                                    _currentHeightSliderValue = imc.height!;
                                    _imcInfoDialog(
                                        context, "Editar IMC", imc, false);
                                  },
                                ),
                                PopupMenuItem(
                                    key: Key(imc.id!),
                                    value: "remove",
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Remover",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(Icons.delete, color: Colors.red),
                                      ],
                                    ),
                                    onTap: () {
                                      _currentWeightSliderValue = imc.weight!;
                                      _currentHeightSliderValue = imc.height!;
                                      _imcInfoDialog(
                                          context,
                                          "Deseja Realmente Remover esse IMC?",
                                          imc,
                                          true);
                                    })
                              ];
                            }),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _currentWeightSliderValue = 0;
            _currentHeightSliderValue = 0;
            _imcInfoDialog(context, "Calcular IMC", null, false);
          },
          child: const Icon(Icons.add)),
    );
  }

  _imcInfoDialog(
      BuildContext context, String title, IMCModel? imc, bool isRemoved) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: isRemoved ? _returnIMCRemoveWrap(imc!) : _returnIMCWrap(),
          actions: _returnIMCActions(imc, isRemoved),
        );
      },
    );
  }

  Widget _returnIMCRemoveWrap(IMCModel imc) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Wrap(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(
                      IconData(
                        imc.imcClassification!.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                      size: 50,
                      color: Color(
                        imc.imcClassification!.color,
                      ),
                    ),
                    Row(
                      children: [
                        Text(imc.imcClassification!.description,
                            style: TextStyle(
                                color: Color(imc.imcClassification!.color),
                                fontSize: 24,
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("IMC: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w800)),
                        Text(imc.imcClassification!.value.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      "Peso:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text("${_currentWeightSliderValue.toStringAsFixed(2)}kg",
                        style: TextStyle(
                            color: Color(imc.imcClassification!.color),
                            fontSize: 24,
                            fontWeight: FontWeight.w800)),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Altura:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text("${_currentHeightSliderValue.toStringAsFixed(2)}m",
                        style: TextStyle(
                            color: Color(imc.imcClassification!.color),
                            fontSize: 24,
                            fontWeight: FontWeight.w800)),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget _returnIMCWrap() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Wrap(
          children: [
            Text((_currentWeightSliderValue == 0)
                ? "Peso (kg)"
                : "Peso (kg) ${_currentWeightSliderValue.toStringAsFixed(2)}"),
            Slider(
              min: 0,
              max: 300,
              value: _currentWeightSliderValue,
              label: _currentWeightSliderValue.toStringAsFixed(2),
              onChanged: (value) {
                setState(() {
                  _currentWeightSliderValue = value;
                });
              },
            ),
            Text((_currentHeightSliderValue == 0)
                ? "Altura (m)"
                : "Altura (m) ${_currentHeightSliderValue.toStringAsFixed(2)}"),
            Slider(
              min: 0,
              max: 4,
              value: _currentHeightSliderValue,
              label: _currentHeightSliderValue.toStringAsFixed(2),
              onChanged: (value) {
                setState(() {
                  _currentHeightSliderValue = value;
                });
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> _returnIMCActions(IMCModel? imc, bool isRemoved) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ),
          isRemoved
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    onPressed: () {
                      _removeOnPressedAction(imc!);
                    },
                    child: const Text('Remover'),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    onPressed: () {
                      _addOrUpdateOnPressAction(imc);
                    },
                    child: const Text('Calcular'),
                  ),
                ),
        ],
      ),
    ];
  }

  bool _isFieldsValid() {
    if (_currentWeightSliderValue == 0) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(
            duration: Duration(seconds: 2),
            dismissDirection: DismissDirection.down,
            backgroundColor: Colors.red,
            content: Text("O valor de peso não pode ser 0.")));
      return false;
    } else if (_currentHeightSliderValue == 0) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(
            duration: Duration(seconds: 2),
            dismissDirection: DismissDirection.down,
            backgroundColor: Colors.red,
            content: Text("O valor da altura não pode ser 0.")));
      return false;
    } else {
      return true;
    }
  }

  _addOrUpdateOnPressAction(IMCModel? imc) async {
    setState(() {
      isSaving = true;
    });
    if (imc == null) {
      if (_isFieldsValid()) {
        imcRepository.create(IMCModel.create(
            _currentWeightSliderValue, _currentHeightSliderValue));
      } else {
        return;
      }
    } else {
      if (_isFieldsValid()) {
        imc.weight = _currentWeightSliderValue;
        imc.height = _currentHeightSliderValue;
        imc.imcClassification = IMCClassification.createOrUpdate(
            CalculateIMC.calculateIMC(
                _currentWeightSliderValue, _currentHeightSliderValue));
        imcRepository.update(imc);
      } else {
        return;
      }
    }
    loadIMC();
    setState(() {
      isSaving = false;
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          dismissDirection: DismissDirection.down,
          backgroundColor: Colors.green,
          content: Text("IMC Salvos com Sucesso!")));
  }

  _removeOnPressedAction(IMCModel imc) async {
    setState(() {
      isSaving = true;
    });

    imcRepository.remove(imc);
    loadIMC();
    setState(() {
      isSaving = false;
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        dismissDirection: DismissDirection.down,
        backgroundColor: Colors.green,
        content: Text("IMC Removido com Sucesso!")));
  }
}
