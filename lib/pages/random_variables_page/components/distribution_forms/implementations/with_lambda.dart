import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_generators/pages/random_variables_page/components/distribution_forms/distribution_form.dart';

class WithLambda extends DistributionForm {
  WithLambda({super.key, required super.onSubmit});

  final TextEditingController lamndaController = TextEditingController();
  get lamnda => int.parse(lamndaController.text);

  @override
  List<Widget> get formFields => [_getLamndaFormField()];

  _getLamndaFormField() {
    return Column(
      children: [
        TextFormField(
          controller: lamndaController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Semilla",
              hintText: "Ingrese la semilla"),
        )
      ],
    );
  }
}
