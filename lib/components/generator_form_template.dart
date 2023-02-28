import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/components/sidebar.dart';
import 'package:random_generators/models/generator_state.dart';

class GeneratorFormField {
  final String fieldName;
  final Widget formField;

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
