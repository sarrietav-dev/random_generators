import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_generators/modules/generators/generators/xor_shift.dart';

import '../generator_widget_factory.dart';

class XorShiftWidget extends GeneratorFormWidget {
  XorShiftWidget({super.key});

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final TextEditingController seedController = TextEditingController();
  get seed => int.parse(seedController.text, radix: 2);

  final TextEditingController kController = TextEditingController();
  get k => int.parse(kController.text);

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
                  controller: seedController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[01]")),
                  ],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Semilla",
                      hintText: "Ingrese la semilla"),
                ),
                TextFormField(
                  controller: kController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "K",
                      hintText: "Ingrese k"),
                ),
              ],
            ),
          ],
        ));
  }

  @override
  List<int> getNumbers() {
    final XorShift xorShift =
        XorShift(n: seedController.text.length, seed: seed, k: k, taps: [1]);
    return List.generate(100, (index) => xorShift.nextNumber());
  }

  @override
  GlobalKey<FormState> get formState => _formState;
}
