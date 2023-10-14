import 'package:dio_dart_flutter_calculadora_imc/model/imc.dart';
import 'package:dio_dart_flutter_calculadora_imc/repositories/imc_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var imcRepository = IMCRepository();
  var _imcs = <IMC>[];
  var imc = IMC(0, 0);

  double _currentWeightSliderValue = 0;
  double _currentHeightSliderValue = 0;

  bool isSaving = false;
  // bool isListExtended = false;
  int checkedIndex = -1;

  void loadIMC() async {
    _imcs = await imcRepository.getIMCs();
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
                        leading: Icon(imc.classification.icon,
                            color: imc.classification.color),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(imc.classification.description,
                                style: TextStyle(
                                    color: imc.classification.color,
                                    fontWeight: FontWeight.bold)),
                            Text(imc.classification.value.toStringAsFixed(2),
                                style: TextStyle(
                                    color: imc.classification.color,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        subtitle: (checkedIndex == index) ? Text("data") : null,
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
                                  key: Key(imc.id),
                                  value: "update",
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Editar"),
                                      Icon(Icons.edit),
                                    ],
                                  ),
                                  onTap: () {
                                    _currentWeightSliderValue = imc.weight;
                                    _currentHeightSliderValue = imc.height;
                                    _imcInfoDialog(
                                        context, "Editar IMC", imc, false);
                                  },
                                ),
                                PopupMenuItem(
                                    key: Key(imc.id),
                                    value: "remove",
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Remover"),
                                        Icon(Icons.delete),
                                      ],
                                    ),
                                    onTap: () {
                                      _currentWeightSliderValue = imc.weight;
                                      _currentHeightSliderValue = imc.height;
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

  _imcInfoDialog(BuildContext context, String title, IMC? imc, bool isRemoved) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: isRemoved ? _returnIMCRemoveWrap(imc) : _returnIMCWrap(),
          actions: _returnIMCActions(imc, isRemoved),
        );
      },
    );
  }

  Widget _returnIMCRemoveWrap(IMC? imc) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Wrap(
          children: [
            Text("Peso (kg) ${_currentWeightSliderValue.toStringAsFixed(2)}"),
            Text("Altura (m) ${_currentHeightSliderValue.toStringAsFixed(2)}"),
            Text("IMC:  ${imc!.classification.value.toStringAsFixed(2)}"),
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

  List<Widget> _returnIMCActions(IMC? imc, bool isRemoved) {
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
                      _removeOnPressedAction(imc);
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

  _addOrUpdateOnPressAction(IMC? imc) async {
    setState(() {
      isSaving = false;
    });
    if (_currentWeightSliderValue == 0) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(
            duration: Duration(seconds: 2),
            dismissDirection: DismissDirection.down,
            backgroundColor: Colors.red,
            content: Text("O valor de peso não pode ser 0.")));
      return;
    } else if (_currentHeightSliderValue == 0) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(
            duration: Duration(seconds: 2),
            dismissDirection: DismissDirection.down,
            backgroundColor: Colors.red,
            content: Text("O valor da altura não pode ser 0.")));
      return;
    }
    setState(() {
      isSaving = true;
    });

    if (imc == null) {
      await imcRepository
          .addIMC(IMC(_currentWeightSliderValue, _currentHeightSliderValue));
    } else {
      await imcRepository.updateIMC(
          imc.id, _currentWeightSliderValue, _currentHeightSliderValue);
    }
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          isSaving = false;
        });
      },
    );

    if (!mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          dismissDirection: DismissDirection.down,
          backgroundColor: Colors.green,
          content: Text("IMC Salvos com Sucesso!")));
  }

  _removeOnPressedAction(IMC? imc) async {
    setState(() {
      isSaving = true;
    });
    if (imc == null) {
      return;
    } else {
      await imcRepository.removeIMC(imc.id);
    }

    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        setState(() {
          isSaving = false;
        });
      },
    );

    if (!mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        dismissDirection: DismissDirection.down,
        backgroundColor: Colors.green,
        content: Text("IMC Removido com Sucesso!")));
  }
}
