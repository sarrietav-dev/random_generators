import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_generators/modules/generators/generator_widgets/generator_form_template.dart';

import '../../generators/middle_squared.dart';

class MiddleSquaredWidget extends GeneratorFormTemplate {
  MiddleSquaredWidget({super.key});

  final TextEditingController seedController = TextEditingController();
  get seed => int.parse(seedController.text);

  _buildSeedFormField() {
    return Column(
      children: [
        TextFormField(
          controller: seedController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
  List<double> get numbers {
    var middleSquared = MiddleSquared(seed: seed);
    return List.generate(100, (index) => middleSquared.nextNumber().toDouble());
  }
}
