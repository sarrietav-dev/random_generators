import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            if (!_formState.currentState!.validate()) return;

            var numbers = widget.numbers;

            Provider.of<GeneratorState>(context, listen: false)
                .setNumbers(numbers);
          },
        )
      ],
    );
  }
}

class GenerateButton extends StatelessWidget {
  const GenerateButton({super.key, required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
            minimumSize: const Size.fromHeight(50)),
        onPressed: () => onPressed(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.casino, size: 20),
            SizedBox(
              width: 10,
            ),
            Text("Generar")
          ],
        ));
  }
}
