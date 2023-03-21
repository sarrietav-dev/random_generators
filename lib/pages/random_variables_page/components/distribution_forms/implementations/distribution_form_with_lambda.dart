import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_generators/pages/random_variables_page/components/distribution_forms/distribution_form.dart';

abstract class DistributionFormWithLambda extends DistributionForm {
  DistributionFormWithLambda({super.key});

  final TextEditingController lamndaController = TextEditingController();
  get lamnda => int.parse(lamndaController.text);

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
}
