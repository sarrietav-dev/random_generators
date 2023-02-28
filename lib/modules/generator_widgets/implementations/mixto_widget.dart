import 'package:flutter/material.dart';
import 'package:random_generators/components/generator_form_template.dart';
import 'package:random_generators/modules/generators/generators/mixto.dart';
import 'package:random_generators/validators/validators.dart';

class MixtoWidget extends GeneratorFormTemplate {
  MixtoWidget({super.key});

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

        return null;
      },
      controller: seedController,
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
          return 'El valor debe ser impar';
        }

        return null;
      },
      controller: aValueController,
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
          return 'El valor debe ser impar';
        }

        if (parsedValue % 8 != 5) {
          return 'El valor debe ser congruente con 5 (mod 8)';
        }

        if (!Validators.isPrime(parsedValue)) {
          return 'El valor debe ser primo';
        }

        return null;
      },
      controller: cValueController,
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
          return 'El valor debe ser primo';
        }

        return null;
      },
      controller: mValueController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "m",
          hintText: "Ingrese el valor m"),
    );
  }

  @override
  List<GeneratorFormField> get formFields {
    return [
      GeneratorFormField(fieldName: "", formField: _buildSeedInput()),
      GeneratorFormField(fieldName: "", formField: _buildAValueInput()),
      GeneratorFormField(fieldName: "", formField: _buildCValueInput()),
      GeneratorFormField(fieldName: "", formField: _buildMValueInput()),
    ];
  }

  @override
  List<int> get numbers {
    var mixto = Mixto(a: a, c: c, m: m, seed: seed);
    return List.generate(100, (index) => mixto.nextNumber());
  }
}
