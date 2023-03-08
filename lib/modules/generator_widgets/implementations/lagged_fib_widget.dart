import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_generators/components/generator_form_template.dart';

import '../../generators/generators/lagged_fib.dart';

class LaggedFibonacciWidget extends GeneratorFormTemplate {
  LaggedFibonacciWidget({super.key});

  final TextEditingController seedController = TextEditingController();

  get seed => int.parse(seedController.text);

  final TextEditingController aValueController = TextEditingController();
  get a => int.parse(aValueController.text);

  final TextEditingController mValueController = TextEditingController();
  get m => int.parse(mValueController.text);

  _buildSeedFormField() {
    return Column(
      children: [
        TextFormField(
          controller: seedController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Ingrese un valor";
            }

            if (value.split("").length < 7) {
              return "La semilla debe tener al menos 7 dígitos";
            }
            return null;
          },
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Semilla",
              hintText: "Ingrese la semilla"),
        ),
      ],
    );
  }

  _buildMFormField() {
    return Column(
      children: [
        TextFormField(
          controller: mValueController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Ingrese un valor";
            }

            if (int.parse(value) < 2) {
              return "El valor de m debe ser mayor a 1";
            }
            return null;
          },
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "m",
              hintText: "Ingrese el valor m"),
        ),
      ],
    );
  }

  @override
  List<Widget> get formFields => [
        _buildSeedFormField(),
        _buildMFormField(),
      ];

  @override
  List<String> getWarnings(BuildContext context) {
    return [];
  }

  @override
  List<double> get numbers {
    var lagFib = LaggedFibonacci(seed: seed, mod: m);
    return List.generate(100, (index) => lagFib.nextNumber().toDouble());
  }
}
