import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/models/random_variable_state.dart';
import 'package:random_generators/modules/random_variable_generators/poisson.dart';
import 'package:random_generators/pages/random_variables_page/components/distribution_forms/implementations/distribution_form_with_lambda.dart';

class PoissonForm extends DistributionFormWithLambda {
  PoissonForm({super.key});

  @override
  onSubmit(BuildContext context) {
    var poisson = PoissonDistVariable(lambda: super.lamnda);

    var provider = Provider.of<RandomVariableState>(context);

    var randomVariables = provider.randomNumbers.map((e) => poisson.get(e));

    provider.randomVariables = randomVariables.toList();
  }
}
