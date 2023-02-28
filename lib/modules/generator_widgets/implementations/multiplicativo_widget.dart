import 'package:flutter/material.dart';
import 'package:random_generators/components/generator_form_template.dart';
import 'package:random_generators/modules/generator_widgets/generator_widget_factory.dart';
import 'package:random_generators/modules/generators/generators/multiplicativo.dart';

class MultiplicativoWidget extends GeneratorFormTemplate {
  MultiplicativoWidget({super.key});

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
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Semilla",
              hintText: "Ingrese la semilla"),
        ),
      ],
    );
  }

  _buildAFormField() {
    return Column(
      children: [
        TextFormField(
          controller: aValueController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "a",
              hintText: "Ingrese el valor a"),
        ),
      ],
    );
  }

  _buildMFormField() {
    return Column(
      children: [
        TextFormField(
          controller: mValueController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "m",
              hintText: "Ingrese el valor m"),
        ),
      ],
    );
  }

  @override
  List<GeneratorFormField> get formFields => [
        GeneratorFormField(fieldName: "", formField: _buildSeedFormField()),
        GeneratorFormField(fieldName: "", formField: _buildAFormField()),
        GeneratorFormField(fieldName: "", formField: _buildMFormField()),
      ];

  @override
  List<int> get numbers {
    var mixto = Multiplicativo(a: a, m: m, seed: seed);
    return List.generate(100, (index) => mixto.nextNumber());
  }
}
