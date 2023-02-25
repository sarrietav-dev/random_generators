import 'package:flutter/material.dart';
import 'package:random_generators/modules/generator_widgets/generator_widget_factory.dart';
import 'package:random_generators/modules/generators/generators/multiplicativo.dart';

class MultiplicativoWidget extends GeneratorFormWidget {
  MultiplicativoWidget({super.key});

  final TextEditingController seedController = TextEditingController();

  get seed => int.parse(seedController.text);

  final TextEditingController aValueController = TextEditingController();
  get a => int.parse(aValueController.text);

  final TextEditingController mValueController = TextEditingController();
  get m => int.parse(mValueController.text);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: ListView(
      children: [
        Wrap(
          runSpacing: 15,
          children: [
            TextFormField(
              controller: seedController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Semilla",
                  hintText: "Ingrese la semilla"),
            ),
            TextFormField(
              controller: aValueController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "a",
                  hintText: "Ingrese el valor a"),
            ),
            TextFormField(
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
    var mixto = Multiplicativo(a: a, m: m, seed: seed);
    return List.generate(100, (index) => mixto.nextNumber());
  }
}
