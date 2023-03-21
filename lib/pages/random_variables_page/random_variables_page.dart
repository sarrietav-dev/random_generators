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
                sidebarChild: Column(
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
                child: ListView(children: [
                  NumberList(numbers: state.randomNumbers),
                ]));
          },
        ));
  }
}
