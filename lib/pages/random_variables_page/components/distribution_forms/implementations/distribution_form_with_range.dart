import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/models/random_variable_state.dart';
import 'package:random_generators/modules/random_variable_generators/uniform.dart';
import 'package:random_generators/pages/random_variables_page/components/distribution_forms/distribution_form.dart';

class DistributionFormWithRange extends DistributionForm {
  DistributionFormWithRange({super.key});

  final TextEditingController aController = TextEditingController(text: '0');
  get a => double.parse(aController.text);
  final TextEditingController bController = TextEditingController(text: '0');
  get b => double.parse(bController.text);

  @override
  List<Widget> get formFields => [
        _getLimitFormField(controller: aController, label: "a"),
        _getLimitFormField(controller: bController, label: "b")
      ];

  _getLimitFormField(
      {required TextEditingController controller, required String label}) {
    return TextFormField(
      controller: controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          hintText: "Ingrese $label"),
    );
  }

  @override
  onSubmit(BuildContext context) {
    var generator = UniformDistVariable(a: a, b: b);

    var provider = Provider.of<RandomVariableState>(context, listen: false);

    var randomVariables = provider.randomNumbers.map((e) => generator.get(e));

    return randomVariables.toList();
  }
}
