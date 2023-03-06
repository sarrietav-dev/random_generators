import 'package:flutter/material.dart';
import 'package:random_generators/components/number_list.dart';

class StatTesterWidget extends StatelessWidget {
  const StatTesterWidget({super.key, required this.numbers});

  final List<double> numbers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pruebas estadisticas"),
      ),
      body: Row(children: [
        Expanded(child: ListView(children: [NumberList(numbers: numbers)])),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: TestCard(
                        test: () => true, title: "Prueba del promedio")),
                Expanded(
                    child: TestCard(
                        test: () => false, title: "Prueba de las frecuencias"))
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class TestCard extends StatelessWidget {
  const TestCard({
    super.key,
    required this.test,
    required this.title,
  });

  final bool Function() test;
  final String title;

  getColor({required bool testResult}) =>
      testResult ? Colors.green : Colors.red;

  @override
  Widget build(BuildContext context) {
    var testResult = test();
    return Card(
        color: getColor(testResult: testResult),
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
            child: Text(title,
                style: const TextStyle(color: Colors.white, fontSize: 25)),
          )
        ]));
  }
}
