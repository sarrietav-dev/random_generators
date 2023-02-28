import 'package:flutter/material.dart';
import 'package:random_generators/modules/generators/generators/mixto.dart';
import 'package:random_generators/validators/validators.dart';

class MixtoWidget extends StatefulWidget {
  const MixtoWidget({super.key});

  @override
  State<MixtoWidget> createState() => _MixtoWidgetState();
}

class _MixtoWidgetState extends State<MixtoWidget> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  final TextEditingController seedController = TextEditingController();

  get seed => int.parse(seedController.text);

  final TextEditingController aValueController = TextEditingController();

  get a => int.parse(aValueController.text);

  final TextEditingController cValueController = TextEditingController();

  get c => int.parse(cValueController.text);

  final TextEditingController mValueController = TextEditingController();

  get m => int.parse(mValueController.text);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formState,
        child: ListView(
          children: [
            Wrap(
              runSpacing: 15,
              children: [
                TextFormField(
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
                ),
                TextFormField(
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
                ),
                TextFormField(
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
                ),
                TextFormField(
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
                ),
              ],
            ),
          ],
        ));
  }

  @override
  List<int> getNumbers() {
    var mixto = Mixto(a: a, c: c, m: m, seed: seed);
    return List.generate(100, (index) => mixto.nextNumber());
  }

  @override
  GlobalKey<FormState> get formState => _formState;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
