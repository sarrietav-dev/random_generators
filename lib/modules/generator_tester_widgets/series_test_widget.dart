import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_generators/modules/generator_tester_widgets/abstraction/generator_tester_widget.dart';
import 'package:random_generators/modules/generator_testers/abstraction/generator_tester.dart';
import 'package:random_generators/modules/generator_testers/series_tester.dart';

class SeriesTestWidget extends GeneratorTesterWidget {
  const SeriesTestWidget({super.key, required super.numbers});

  @override
  State<SeriesTestWidget> createState() => _SeriesTestWidgetState();
}

class _SeriesTestWidgetState extends State<SeriesTestWidget> {
  late GeneratorTester test;
  late bool testResult;
  double statistical = 0;
  int intervalNumber = 5;
  String helperText = "";

  @override
  void initState() {
    test = SeriesTester(numbers: widget.numbers, intervals: intervalNumber);
    testResult = test.test();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: widget.getColor(testResult),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                    child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                )),
                Center(
                  child: Icon(
                    testResult ? Icons.check : Icons.close,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Prueba de series",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Expanded(
                    child: TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      initialValue: intervalNumber.toString(),
                      decoration: InputDecoration(
                          hintText: "Ingrese el numero de intervalos",
                          helperText: helperText,
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: widget.getColor(testResult)[700],
                                  width: 3)),
                          fillColor: widget.getColor(testResult)[50],
                          filled: true),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            testResult = false;
                            helperText = "Ingrese el numero de intervalos";
                          });
                          return;
                        }
                  
                        var intValue = int.parse(value);
                  
                        if (intValue <= 1 || intValue > 10) {
                          setState(() {
                            helperText =
                                "El numero de intervalos debe estar entre 2 y 10";
                            testResult = false;
                          });
                          return;
                        }
                  
                        intervalNumber = intValue;
                  
                        setState(() {
                          test = SeriesTester(
                              numbers: widget.numbers, intervals: intervalNumber);
                          testResult = test.test();
                  
                          if (testResult) {
                            helperText =
                                "No se puede rechazar que los numeros sean independientes";
                          } else {
                            helperText =
                                "Se puede rechazar que los numeros sean independientes";
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
