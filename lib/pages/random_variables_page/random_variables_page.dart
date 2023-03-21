import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/components/number_list.dart';
import 'package:random_generators/layout/page_with_sidebar.dart';
import 'package:random_generators/models/random_variable_state.dart';
import 'package:random_generators/modules/random_variable_generators/exponential.dart';
import 'package:random_generators/modules/random_variable_generators/poisson.dart';
import 'package:random_generators/pages/random_variables_page/components/distribution_dropdown.dart';
import 'package:random_generators/pages/random_variables_page/components/distribution_forms/implementations/distribution_form_with_lambda.dart';

import 'components/distribution_forms/implementations/distribution_form_with_range.dart';
import 'package:collection/collection.dart';

class RandomVariablesPage extends StatelessWidget {
  const RandomVariablesPage({super.key});

  _getDistributionForm(RandomVariableState state) {
    switch (state.getDistribution()) {
      case Distributions.exponential:
        return DistributionFormWithLambda(
          (lambda) => ExponentialDistVariable(lambda: lambda),
        );
      case Distributions.poisson:
        return DistributionFormWithLambda(
          (lambda) => PoissonDistVariable(lambda: lambda),
        );
      case Distributions.uniform:
        return DistributionFormWithRange();
      default:
        return const Text("Por favor elije una distribución");
    }
  }

  _getTable(RandomVariableState state) {
    var randomNumbers = state.randomNumbers;
    var randomVariables = state.randomVariables;

    if (randomVariables.isEmpty) {
      return NumberList(numbers: randomNumbers);
    } else {
      var zippedNumbers = IterableZip([randomNumbers, randomVariables]);

      return DataTable(columns: const [
        DataColumn(
            label: Text("Numers aleatorios"),
            tooltip: "Numeros aleatorios generados"),
        DataColumn(
            label: Text("Variables aleatorias"),
            tooltip: "Variables aleatorias generadas")
      ], rows: [
        ...zippedNumbers
            .map(
              (numbers) => DataRow(
                cells: [
                  DataCell(
                    Text(numbers[0].toString()),
                  ),
                  DataCell(
                    Text(numbers[1].toString()),
                  )
                ],
              ),
            )
            .toList()
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Random Variables'),
        ),
        body: Consumer<RandomVariableState>(
          builder: (context, state, child) {
            var entries = state.distributionNames;

            return PageWithSidebar(
                sidebarChild: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      DistributionDropdown(
                          entries: entries,
                          onSelected: (value) => state.distribution =
                              state.mapIntToDistribution(value!)),
                      Expanded(
                        child: _getDistributionForm(state),
                      )
                    ],
                  ),
                ),
                child: ListView(children: [_getTable(state)]));
          },
        ));
  }
}
