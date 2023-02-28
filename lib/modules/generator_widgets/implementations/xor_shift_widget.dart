import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_generators/components/generator_form_template.dart';
import 'package:random_generators/modules/generators/generators/xor_shift.dart';

class XorShiftWidget extends GeneratorFormTemplate {
  XorShiftWidget({super.key});

  final TextEditingController seedController = TextEditingController();
  get seed => int.parse(seedController.text, radix: 2);
  final TextEditingController kController = TextEditingController();
  get k => int.parse(kController.text);

  _getSeedFormField() {
    return Column(
      children: [
        TextFormField(
          controller: seedController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[01]")),
          ],
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Semilla",
              hintText: "Ingrese la semilla"),
        ),
      ],
    );
  }

  _getKFormField() {
    String warning = "";

    return Column(
      children: [
        TextFormField(
          controller: kController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Ingrese un valor";
            }
            if (int.parse(value) > 2 ^ 32) {
              warning = "No puede ser mayor a 2^32";
            }
            return null;
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "K",
              hintText: "Ingrese k"),
        ),
        const SizedBox(height: 5),
        if (warning.isNotEmpty)
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded,
                  color: Colors.amber, size: 20),
              const SizedBox(width: 7.5),
              Text(warning, style: const TextStyle(color: Colors.amber)),
            ],
          )
      ],
    );
  }

  @override
  List<GeneratorFormField> get formFields => [
        GeneratorFormField(fieldName: "seed", formField: _getSeedFormField()),
        GeneratorFormField(
          fieldName: "k",
          formField: _getKFormField(),
        ),
      ];

  @override
  List<int> get numbers {
    final XorShift xorShift =
        XorShift(n: seedController.text.length, seed: seed, k: k, taps: [1]);
    return List.generate(100, (index) => xorShift.nextNumber());
  }
}
