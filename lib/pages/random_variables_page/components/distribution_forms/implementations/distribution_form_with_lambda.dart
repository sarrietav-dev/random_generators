import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/models/random_variable_state.dart';
import 'package:random_generators/modules/random_variable_generators/random_variable_generator.dart';
import 'package:random_generators/pages/random_variables_page/components/distribution_forms/distribution_form.dart';

class DistributionFormWithLambda extends DistributionForm {
  DistributionFormWithLambda(this.randomVariableGenerator, {super.key});

  final RandomVariableGenerator Function(double lambda) randomVariableGenerator;

  final TextEditingController lamndaController = TextEditingController();
  get lambda => int.parse(lamndaController.text);

  @override
  List<Widget> get formFields => [_getLamndaFormField()];

  _getLamndaFormField() {
    return TextFormField(
      controller: lamndaController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Lamnda",
          hintText: "Ingrese lambda"),
    );
  }

  @override
  onSubmit(BuildContext context) {
    var generator = randomVariableGenerator(lambda);

    var provider = Provider.of<RandomVariableState>(context);

    var randomVariables = provider.randomNumbers.map((e) => generator.get(e));

    provider.randomVariables = randomVariables.toList();
  }
}
