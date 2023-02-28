import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/components/sidebar.dart';
import 'package:random_generators/models/generator_state.dart';
import 'package:random_generators/modules/generators/generators/xor_shift.dart';

class GeneratorFormField {
  final String fieldName;
  final TextFormField formField;

  GeneratorFormField({required this.fieldName, required this.formField});
}

abstract class GeneratorFormTemplate extends StatefulWidget {
  const GeneratorFormTemplate({super.key});

  List<GeneratorFormField> get formFields;
  List<int> get numbers;

  @override
  State<GeneratorFormTemplate> createState() => _GeneratorFormTemplateState();
}

class _GeneratorFormTemplateState extends State<GeneratorFormTemplate> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  Map<String, TextEditingController> _controllers = {};

  _buildForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      child: Form(
          key: _formState,
          child: ListView(
            children: [
              Wrap(
                runSpacing: 15,
                children: [
                  for (var field in widget.formFields) field.formField,
                ],
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildForm()),
        GenerateButton(
          onPressed: () {
            var numbers = widget.numbers;

            Provider.of<GeneratorState>(context, listen: false)
                .setNumbers(numbers);
          },
        )
      ],
    );
  }
}

class TestForm extends GeneratorFormTemplate {
  TextEditingController seedController = TextEditingController();
  get seed => int.parse(seedController.text, radix: 2);
  TextEditingController kController = TextEditingController();
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
  // TODO: implement numbers
  List<int> get numbers {
    final XorShift xorShift =
        XorShift(n: seedController.text.length, seed: seed, k: k, taps: [1]);
    return List.generate(100, (index) => xorShift.nextNumber());
  }
}
