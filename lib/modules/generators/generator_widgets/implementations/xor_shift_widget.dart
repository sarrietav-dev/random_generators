import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_generators/modules/generators/generator_widgets/generator_form_template.dart';
import 'package:random_generators/components/warning.dart';
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
    List<String> warnings = [];

    return Column(
      children: [
        TextFormField(
          controller: kController,
          validator: (value) {
            warnings = [];
            if (value == null || value.isEmpty) {
              return "Ingrese un valor";
            }
            if (int.parse(value) > 2 ^ 32) {
              warnings.add("No puede ser mayor a 2^32");
            }
            return null;
          },
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "K",
              hintText: "Ingrese k"),
        ),
        if (warnings.isNotEmpty)
          for (var warning in warnings) Warning(message: warning),
      ],
    );
  }

  @override
  List<Widget> get formFields => [_getSeedFormField(), _getKFormField()];

  @override
  List<double> get numbers {
    final XorShift xorShift =
        XorShift(n: seedController.text.length, seed: seed, k: k, taps: [1]);
    return List.generate(k * 100, (index) => xorShift.nextNumber().toDouble());
  }

  @override
  List<String> getWarnings(BuildContext context) {
    return [];
  }
}
