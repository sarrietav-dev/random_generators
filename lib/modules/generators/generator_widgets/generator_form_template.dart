import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/components/warning.dart';
import 'package:random_generators/helpers/period_proxy.dart';
import 'package:random_generators/models/generator_state.dart';

abstract class GeneratorFormTemplate extends StatefulWidget {
  const GeneratorFormTemplate({super.key});

  List<Widget> get formFields;
  List<double> get numbers;
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
        _GenerateButton(
          onPressed: () {
            var isValid = _formState.currentState!.validate();
            warnings = widget.getWarnings(context);
            if (!isValid) {
              setState(() {
                Provider.of<GeneratorState>(context).addWarnings(warnings);
              });
            }

            var numbers = periodProxy(widget.numbers);

            showConvertFormatPopup(context).then((value) {
              if (value != null && value) {
                convertNumbers(numbers, context);
              } else {
                Provider.of<GeneratorState>(context, listen: false)
                    .setNumbers(numbers);
              }
            });
          },
        )
      ],
    );
  }

  Future<bool?> showConvertFormatPopup(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Convertir a números entre 0 y 1"),
            content: const Text(
                "¿Desea convertir los números generados a números entre 0 y 1?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Sí")),
            ],
          );
        });
  }

  /// Converts the numbers to numbers between 0 and 1
  convertNumbers(List<double> numbers, BuildContext context) {
    var max =
        numbers.reduce((value, element) => value > element ? value : element);

    numbers = numbers.map((e) => e / (max + 1)).toList();
    Provider.of<GeneratorState>(context, listen: false).setNumbers(numbers);
  }
}

class _GenerateButton extends StatelessWidget {
  const _GenerateButton({required this.onPressed});

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
