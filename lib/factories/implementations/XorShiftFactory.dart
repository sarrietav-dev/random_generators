import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:random_generators/factories/generator_factories.dart';
import 'package:random_generators/modules/generators/generator.dart';
import 'package:random_generators/modules/generators/generators/xor_shift.dart';

class XorShiftFactory implements GeneratorFactory {
  @override
  Widget getForm() {
    return _XorShiftWidget();
  }

  @override
  Generator getGenerator() {
    return XorShift(n: 1, seed: 1, taps: [1], k: 2);
  }
}

class _XorShiftWidget extends StatelessWidget {
  _XorShiftWidget();
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
        k: 8,
        n: seedController.text.length,
        seed: int.parse(seedController.text, radix: 2),
        taps: [1]);
    return List.generate(100, (index) => xorShift.nextNumber());
  }
}
