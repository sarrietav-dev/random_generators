import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_generators/components/generator_form_template.dart';
import 'package:random_generators/modules/generators/generators/blum_blum_shub.dart';

class BlumBlumShubWidget extends GeneratorFormTemplate {
  BlumBlumShubWidget({super.key});

  final TextEditingController seedController = TextEditingController();
  get seed => int.parse(seedController.text);

  final TextEditingController pController = TextEditingController();
  get p => int.parse(pController.text);

  final TextEditingController qController = TextEditingController();
  get q => int.parse(qController.text);

  final TextEditingController kController = TextEditingController();
  get k => int.parse(kController.text);

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

  _buildPFormField() {
    return Column(
      children: [
        TextFormField(
          controller: pController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "P",
              hintText: "Ingrese p"),
        ),
      ],
    );
  }

  _buildQFormField() {
    return Column(
      children: [
        TextFormField(
          controller: qController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Q",
              hintText: "Ingrese q"),
        ),
      ],
    );
  }

  _buildKFormField() {
    return Column(
      children: [
        TextFormField(
          controller: kController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "K",
              hintText: "Ingrese k"),
        ),
      ],
    );
  }

  @override
  List<Widget> get formFields {
    return [
      _buildSeedFormField(),
      _buildPFormField(),
      _buildQFormField(),
      _buildKFormField(),
    ];
  }

  @override
  List<int> get numbers {
    var bbs = BlumBlumShub(p: p, q: q, seed: seed);
    return List.generate(100, (index) => bbs.nextInt());
  }

  @override
  List<String> getWarnings(BuildContext context) {
    return [];
  }
}
