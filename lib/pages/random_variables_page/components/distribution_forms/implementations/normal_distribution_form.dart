import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/models/random_variable_state.dart';
import 'package:random_generators/modules/random_variable_generators/normal.dart';
import 'package:random_generators/pages/random_variables_page/components/distribution_forms/distribution_form.dart';

class NormalDistributionForm extends DistributionForm {
  NormalDistributionForm({super.key});

  final TextEditingController meanController = TextEditingController(text: '0');
  get mean => double.parse(meanController.text);
  final TextEditingController estDevController =
      TextEditingController(text: '0');
  get estDev => double.parse(estDevController.text);

  @override
  List<Widget> get formFields => [
        _getFormField(controller: meanController, label: "Media"),
        _getFormField(
            controller: estDevController, label: "Desviación Estándar")
      ];

  _getFormField(
      {required TextEditingController controller, required String label}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          hintText: "Ingrese $label"),
    );
  }

  @override
  List<double> onSubmit(BuildContext context) {
    var generator = NormalDistVariable(mean: mean, estDev: estDev);

    var provider = Provider.of<RandomVariableState>(context, listen: false);

    List<double> response = [];

    for (var i = 0; i < provider.randomNumbers.length; i += 2) {
      var u1 = provider.randomNumbers[i];
      var u2 = provider.randomNumbers[i + 1];

      var randomVariables = generator.get(u1, u2);

      response.add(randomVariables[0]);
      response.add(randomVariables[1]);
    }

    return response;
  }
}
