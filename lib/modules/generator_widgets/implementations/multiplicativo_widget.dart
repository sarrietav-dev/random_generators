import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/components/generator_form_template.dart';
import 'package:random_generators/models/generator_state.dart';
import 'package:random_generators/modules/generators/generators/multiplicativo.dart';
import 'package:random_generators/validators/validators.dart';

class MultiplicativoWidget extends GeneratorFormTemplate {
  MultiplicativoWidget({super.key});

  final List<String> _warnings = [];

  final TextEditingController seedController = TextEditingController();
  get seed => int.parse(seedController.text);

  final TextEditingController aValueController = TextEditingController();
  get a => int.parse(aValueController.text);

  final TextEditingController mValueController = TextEditingController();
  get m => int.parse(mValueController.text);

  _buildSeedInput() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un valor';
        }

        int parsedValue = int.parse(value);

        if (parsedValue <= 0) {
          return 'El valor debe ser mayor a 0';
        }

        if (!Validators.isPrime(parsedValue)) {
          _warnings.add('La semilla no es primo');
        }

        return null;
      },
      controller: seedController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Semilla",
          hintText: "Ingrese la semilla"),
    );
  }

  _buildAValueInput() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un valor';
        }

        int parsedValue = int.parse(value);

        if (parsedValue <= 0) {
          return 'El valor debe ser mayor a 0';
        }

        if (parsedValue % 2 == 0) {
          _warnings.add('El valor "a" no es impar');
        }

        if (!Validators.isPrime(parsedValue)) {
          _warnings.add('A no es primo');
        }

        return null;
      },
      controller: aValueController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "a",
          hintText: "Ingrese el valor a"),
    );
  }

  _buildMValueInput() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un valor';
        }

        int parsedValue = int.parse(value);

        if (parsedValue <= 0) {
          return 'El valor debe ser mayor a 0';
        }

        if (parsedValue < seed) {
          return 'El valor debe ser mayor a la semilla';
        }

        if (parsedValue < a) {
          return "El valor debe ser mayor a 'a'";
        }

        if (!Validators.isPrime(parsedValue)) {
          _warnings.add('M no es primo');
        }

        return null;
      },
      controller: mValueController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "m",
          hintText: "Ingrese el valor m"),
    );
  }

  @override
  List<Widget> get formFields =>
      [_buildSeedInput(), _buildAValueInput(), _buildMValueInput()];

  @override
  List<double> get numbers {
    var mixto = Multiplicativo(a: a, m: m, seed: seed);
    return List.generate(100, (index) => mixto.nextNumber().toDouble());
  }

  @override
  List<String> getWarnings(BuildContext context) {
    Provider.of<GeneratorState>(context, listen: false).addWarnings(_warnings);
    return _warnings;
  }
}
