import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/components/number_list.dart';
import 'package:random_generators/helpers/values_in_zero_and_one_checker.dart';
import 'package:random_generators/models/random_variable_state.dart';
import 'package:random_generators/modules/generators/generator_tester_widgets/abstraction/generator_tester_widget.dart';
import 'package:random_generators/modules/generators/generator_tester_widgets/corridas_test_widget.dart';
import 'package:random_generators/modules/generators/generator_tester_widgets/frecuency_test_widget.dart';
import 'package:random_generators/modules/generators/generator_tester_widgets/kolmogorov_smirnov_widget.dart';
import 'package:random_generators/modules/generators/generator_tester_widgets/mean_test_widget.dart';
import 'package:random_generators/modules/generators/generator_tester_widgets/series_test_widget.dart';
import 'package:random_generators/pages/random_variables_page/random_variables_page.dart';

class StatTesterPage extends StatelessWidget {
  const StatTesterPage({super.key, required this.numbers});

  final List<double> numbers;

  @override
  Widget build(BuildContext context) {
    final List<GeneratorTesterWidget> testerWidgets = [
      MeanTestWidget(numbers: numbers),
      FrecuencyTestWidget(numbers: numbers),
      SeriesTestWidget(numbers: numbers),
      KolmogorovSmirnovWidget(numbers: numbers),
      CorridasTestWidget(numbers: numbers)
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pruebas estadisticas"),
      ),
      floatingActionButton: areNumbersBetweenZeroAndOne(numbers)
          ? FloatingActionButton(
              tooltip: "Generar variables aleatorias con estos numeros",
              child: const Icon(Icons.keyboard_arrow_right),
              onPressed: () {
                Provider.of<RandomVariableState>(context, listen: false)
                    .randomNumbers = numbers;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RandomVariablesPage()),
                );
              })
          : null,
      body: Row(children: [
        Expanded(child: ListView(children: [NumberList(numbers: numbers)])),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:
                    testerWidgets.map((e) => Expanded(child: e)).toList()),
          ),
        )
      ]),
    );
  }
}
