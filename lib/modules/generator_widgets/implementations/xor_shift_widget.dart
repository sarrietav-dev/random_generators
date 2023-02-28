import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_generators/components/generator_form_template.dart';
import 'package:random_generators/modules/generators/generators/xor_shift.dart';

import '../generator_widget_factory.dart';

class XorShiftWidget extends GeneratorFormTemplate {
  XorShiftWidget({super.key});

  final TextEditingController seedController = TextEditingController();
  get seed => int.parse(seedController.text, radix: 2);
  final TextEditingController kController = TextEditingController();
  get k => int.parse(kController.text);

  @override
  List<GeneratorFormField> get formFields => [
        GeneratorFormField(
          fieldName: "seed",
          formField: TextFormField(
            controller: seedController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[01]")),
            ],
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Semilla",
                hintText: "Ingrese la semilla"),
          ),
        ),
        GeneratorFormField(
          fieldName: "k",
          formField: TextFormField(
            controller: kController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "K",
                hintText: "Ingrese k"),
          ),
        ),
      ];

  @override
  List<int> get numbers {
    final XorShift xorShift =
        XorShift(n: seedController.text.length, seed: seed, k: k, taps: [1]);
    return List.generate(100, (index) => xorShift.nextNumber());
  }
}
