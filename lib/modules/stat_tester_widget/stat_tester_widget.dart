// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:random_generators/components/number_list.dart';
import 'package:random_generators/modules/generator_testers/abstraction/generator_tester.dart';
import 'package:random_generators/modules/generator_testers/frecuency_tester.dart';
import 'package:random_generators/modules/generator_testers/mean_tester.dart';

class _TestListItem {
  _TestListItem({required this.title, required this.test});

  final String title;
  final GeneratorTester test;
}

class StatTesterWidget extends StatelessWidget {
  StatTesterWidget({super.key, required this.numbers}) {
    tests = [
      _TestListItem(
          title: "Prueba de promedio", test: MeanTester(numbers: numbers)),
      _TestListItem(
          title: "Prueba de frecuencias",
          test: FrecuencyTester(numbers: numbers, intervals: 2))
    ];
  }

  final List<double> numbers;
  List<_TestListItem> tests = [];

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
                children: tests
                    .map((e) => Expanded(
                          child: TestCard(
                            test: e.test.test,
                            title: e.title,
                          ),
                        ))
                    .toList()),
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
