import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:random_generators/modules/generators/generator_widgets/generator_form_template.dart';
import 'package:random_generators/models/generator_state.dart';
import 'package:random_generators/modules/generators/generators/mixto.dart';
import 'package:random_generators/validators/validators.dart';

class MixtoWidget extends GeneratorFormTemplate {
  MixtoWidget({super.key});

  final List<String> _warnings = [];

  final TextEditingController seedController = TextEditingController();

  get seed => int.parse(seedController.text);

  final TextEditingController aValueController = TextEditingController();

  get a => int.parse(aValueController.text);

  final TextEditingController cValueController = TextEditingController();

  get c => int.parse(cValueController.text);

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

          if (parsedValue % 3 == 0) {
            _warnings
                .add('El valor "a" no cumple con la condición (a % 3 != 0)');
          }

          if (parsedValue % 5 == 0) {
            _warnings
                .add('El valor "a" no cumple con la condición (a % 5 != 0)');
          }
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

  _buildCValueInput() {
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
          _warnings.add('El valor "C" no es impar');
        }

        if (parsedValue % 8 != 5) {
          _warnings.add('El valor "C" no cumple con la condición (c % 8 == 5)');
        }

        if (!Validators.isPrime(parsedValue)) {
          _warnings.add('C no es primo');
        }

        return null;
      },
      controller: cValueController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "c",
          hintText: "Ingrese el valor c"),
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

        if (parsedValue < c) {
          return 'El valor debe ser mayor a c';
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
  List<Widget> get formFields {
    return [
      _buildSeedInput(),
      _buildAValueInput(),
      _buildCValueInput(),
      _buildMValueInput(),
    ];
  }

  @override
  List<double> get numbers {
    var mixto = Mixto(a: a, c: c, m: m, seed: seed);
    return List.generate(100, (index) => mixto.nextNumber().toDouble());
  }

  @override
  List<String> getWarnings(BuildContext context) {
    Provider.of<GeneratorState>(context, listen: false).addWarnings(_warnings);
    return _warnings;
  }
}
