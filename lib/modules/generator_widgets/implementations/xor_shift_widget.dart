import 'package:flutter/material.dart';
import 'package:random_generators/modules/generators/xor_shift.dart';

import '../generator_widget_factory.dart';

class XorShiftWidget extends GeneratorFormWidget {
  XorShiftWidget({super.key});
  final TextEditingController seedController = TextEditingController();

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
          ],
        ),
      ],
    ));
  }

  @override
  List<int> getNumbers() {
    final XorShift xorShift = XorShift(
        n: 4, seed: int.parse(seedController.text, radix: 2), taps: [1]);
    return List.generate(100, (index) => xorShift.nextInt(8));
  }
}
