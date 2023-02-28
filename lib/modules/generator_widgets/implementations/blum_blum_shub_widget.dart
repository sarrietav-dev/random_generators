import 'package:flutter/material.dart';
import 'package:random_generators/modules/generator_widgets/generator_widget_factory.dart';
import 'package:random_generators/modules/generators/generators/blum_blum_shub.dart';

class BlumBlumShubWidget extends GeneratorFormWidget {
  BlumBlumShubWidget({super.key});

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final TextEditingController seedController = TextEditingController();
  get seed => int.parse(seedController.text);

  final TextEditingController pController = TextEditingController();
  get p => int.parse(pController.text);

  final TextEditingController qController = TextEditingController();
  get q => int.parse(qController.text);

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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Semilla",
                      hintText: "Ingrese la semilla"),
                ),
                TextFormField(
                  controller: pController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "P",
                      hintText: "Ingrese p"),
                ),
                TextFormField(
                  controller: qController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "q",
                      hintText: "Ingrese q"),
                ),
                TextFormField(
                  controller: kController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "k",
                      hintText: "Ingrese k"),
                ),
              ],
            ),
          ],
        ));
  }

  @override
  List<int> getNumbers() {
    var bbs = BlumBlumShub(p: p, q: q, seed: seed);
    return List.generate(100, (index) => bbs.nextInt());
  }

  @override
  GlobalKey<FormState> get formState => _formState;
}
