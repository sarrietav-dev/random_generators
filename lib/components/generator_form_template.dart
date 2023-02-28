import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/components/warning.dart';
import 'package:random_generators/models/generator_state.dart';

abstract class GeneratorFormTemplate extends StatefulWidget {
  const GeneratorFormTemplate({super.key});

  List<Widget> get formFields;
  List<int> get numbers;
  List<String> getWarnings(BuildContext context);

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
                  for (var field in widget.formFields) field,
                ],
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    var warnings = Provider.of<GeneratorState>(context).warnings;

    return Column(
      children: [
        Expanded(child: _buildForm()),
        if (warnings.isNotEmpty)
          SizedBox(
            height: 150,
            child: ListView(
              children: [
                for (var warning in warnings) Warning(message: warning),
              ],
            ),
          ),
        GenerateButton(
          onPressed: () {
            var isValid = _formState.currentState!.validate();
            warnings = widget.getWarnings(context);
            if (!isValid) {
              setState(() {
                Provider.of<GeneratorState>(context).addWarnings(warnings);
              });
            }

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
