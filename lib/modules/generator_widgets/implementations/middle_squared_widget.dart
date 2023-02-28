import 'package:flutter/material.dart';
import 'package:random_generators/components/generator_form_template.dart';

import '../../generators/generators/middle_squared.dart';

class MiddleSquaredWidget extends GeneratorFormTemplate {
  MiddleSquaredWidget({super.key});

  final TextEditingController seedController = TextEditingController();
  get seed => int.parse(seedController.text);

  _buildSeedFormField() {
    return Column(
      children: [
        TextFormField(
          controller: seedController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Semilla",
              hintText: "Ingrese la semilla"),
        ),
      ],
    );
  }

  @override
  List<Widget> get formFields => [_buildSeedFormField()];

  @override
  List<String> getWarnings(BuildContext context) {
    return [];
  }

  @override
  List<int> get numbers {
    var middleSquared = MiddleSquared(seed: seed);
    return List.generate(100, (index) => middleSquared.nextNumber());
  }
}
